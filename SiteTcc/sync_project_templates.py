import re
import os


class Template:
    def __init__(self, path, vs_template_path=None, sub_templates=None, exclude_cs_files=None):
        self.path = path
        self.vs_template_path = vs_template_path
        self.sub_templates = sub_templates
        self.exclude_cs_files = exclude_cs_files


templates_map = [
    Template('reporting.blazorserver', vs_template_path='BlazorReporting\\net6\\Server'),
    Template('reporting.webassembly', vs_template_path='BlazorReporting\\net6\\Wasm'),
    Template('reporting.webassembly.hosted', sub_templates=[
        Template('DevExpressProjectTemplate.Client', vs_template_path='BlazorReporting\\net6\\WasmHostedClient'),
        Template('DevExpressProjectTemplate.Server', vs_template_path='BlazorReporting\\net6\\WasmHostedServer'),
        # Template('DevExpressProjectTemplate.Shared', vs_template_path='BlazorReporting\\net6\\WasmHostedShared')
    ]),
    Template('reporting', vs_template_path='Reporting\\net60', exclude_cs_files=True),
    Template('reporting.angular', vs_template_path='ReportingAngular\\net60', exclude_cs_files=True),
]

key_map = {
    'add-document-viewer': 'DX_VAR_CreateDocumentViewer',
    'add-viewer': 'DX_VAR_CreateReportViewer',
    'add-report-viewer': 'DX_VAR_CreateReportViewer',
    'add-designer': 'DX_VAR_CreateReportDesigner',
    'add-data-source': 'DX_VAR_RegisterDataSource',
    'AddJsonDataSourceService': 'DX_VAR_AddJsonDataSourceService',
    'AddObjectDataSourceProvider': 'DX_VAR_AddObjectDataSourceProvider',
    'EnableClientRichEdit': 'DX_VAR_EnableClientRichEdit'
}
names_map = {
    'DevExpressProjectTemplate': '<#= DX_VAR_SafeProjectName #>',
    r'(//|<!--)?#endif(\*@| -->)?': '<# } #>',
    r'2\d\.\d-stable': '<#= DX_VAR_NpmPackageVersion #>'
}

excluded_files = [r'.*\.config', r'.*\.csproj', r'nwind*', r'.*\.db', r'.*\.resx']
excluded_folders = ['.template.config', '\\obj', '\\bin']
skipped_extensions = ['.db', '.txt', '.md', '.eot', '.otf', '.woff', '.ttf', '.png', '.ico', '.resx']
root_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..', '..'))
cli_templates_location = os.path.abspath(os.path.dirname(__file__))
vs_templates_root = os.path.join(root_path, 'ASP', 'DevExpress.Web.Projects', 'DevExpress.Web.Projects.Wizard.NetCore')
vs_templates_location = os.path.join(vs_templates_root, 'Templates')
vs_templates_csproj_location = os.path.join(vs_templates_root, 'DevExpress.Web.Projects.Wizard.NetCore.csproj')


def replace_key(match_string):
    result = '<# if(' + match_string.group(2) + ') { #>'
    for key in key_map:
        result = result.replace(key, key_map[key])
    return result


def check_cs_extension(should_process_cs: bool, file_name: str):
    cs_extensions = ['\.cs$', '\.cshtml$']
    contains_cs_extension = any(len(re.findall(cs_extension, file_name)) > 0 for cs_extension in cs_extensions)
    return should_process_cs == contains_cs_extension


def convert_file(path, file_name):
    file = open(os.path.join(path, file_name), 'r', encoding="utf8")
    file_content = file.read()
    is_template_file = len(re.findall(r"(//|@\*|<!--)#if", file_content)) > 0
    result = re.sub(r"(//|@\*|<!--)#if\((.*)\)( {)?(-->)?", replace_key, file_content)
    for name in names_map:
        is_template_file = is_template_file or name in file_content
        result = re.sub(name, names_map[name], result)
    return result, is_template_file


def print_statistics(processed_files, deleted_files):
    added_files = processed_files.copy()
    processed_files = []
    i = 0
    while i < len(added_files):
        file = added_files[i]
        if file in deleted_files:
            deleted_files.remove(file)
            added_files.remove(file)
            processed_files.append(file)
        else:
            i += 1
    print('New files added - {0}'.format(len(added_files)))
    for file in added_files:
        print('\t' + file)
    print('Outdated files removed - {0}'.format(len(deleted_files)))
    for file in deleted_files:
        print('\t' + file)
    print('Files updated - {0}'.format(len(processed_files)))


def clear_directory(target_directory):
    deleted_files = []
    for file in os.listdir(target_directory):
        full_target_name = os.path.join(target_directory, file)
        if os.path.isfile(full_target_name):
            os.remove(full_target_name)
            deleted_files.append(full_target_name.replace(vs_templates_location + '\\', ''))
    return deleted_files


def convert_project_template(template_name: str, current_template_path: str, exclude_cs_files: bool = None):
    if exclude_cs_files is not None:
        current_template_path = os.path.join(current_template_path, 'CS' if exclude_cs_files else 'Common')
    source_folder = os.path.join(cli_templates_location, template_name)
    target_folder = os.path.join(vs_templates_location, current_template_path)

    processed_files = []
    deleted_files = []
    for path, current_directory, files in os.walk(source_folder):
        if any(folder in path for folder in excluded_folders):
            continue
        target_directory = path.replace(source_folder, target_folder)
        if os.path.isdir(target_directory):
            deleted_files.extend(clear_directory(target_directory))
        for file in files:
            full_source_name = os.path.join(path, file)
            new_file_name = file.replace('_', '__').replace('.', '_')
            full_target_name = os.path.join(target_directory, new_file_name)
            relative_path = full_target_name.replace(vs_templates_location + '\\', '')
            # print(full_source_name.replace(cli_templates_location + '\\', ''), end=" ")
            if any(len(re.findall(excluded_file, file)) > 0 for excluded_file in excluded_files) and relative_path not in deleted_files:
                # print(' -> Skipped')
                continue
            if exclude_cs_files is not None and not check_cs_extension(exclude_cs_files, file):
                continue
            if any(extension in file for extension in skipped_extensions):
                os.system('copy {0} {1}'.format(full_source_name, full_target_name))
                # print(' -> Copied to ' + relative_path)
                processed_files.append(relative_path)
                continue
            if not os.path.isdir(target_directory):
                os.mkdir(target_directory)
            converted_file, is_template_file = convert_file(path, file)
            new_file_name += ('.t4' if is_template_file else '')
            full_target_name = os.path.join(target_directory, new_file_name)
            new_file = open(full_target_name, 'w', encoding="utf8")
            new_file.write(converted_file)
            relative_path = full_target_name.replace(vs_templates_location + '\\', '')
            # print(' -> Processed in ' + relative_path)
            processed_files.append(relative_path)
    print('\nFor project: {0}'.format(current_template_path))
    print_statistics(processed_files, deleted_files)
    return processed_files


def sync_csproj(processed_files, template_name: str):
    csproj = open(vs_templates_csproj_location, 'r', encoding="utf8")
    template_marker = '<!-- {0} -->\n'.format(template_name)
    bottom_marker = '<!---->'
    csproj_content_parts = csproj.read().split(template_marker)
    if len(csproj_content_parts) < 2:
        raise Exception('.csproj file is broken. No {0} marker found'.format(template_marker))
    bottom_parts = csproj_content_parts[1].split(bottom_marker)
    bottom_parts.pop(0)
    bottom_part = bottom_marker.join(bottom_parts)
    imports = template_marker + '  <ItemGroup>\n'
    for file in processed_files:
        imports += '    <EmbeddedResource Include="Templates\{0}" />\n'.format(file)
    imports += '\t</ItemGroup>\n  ' + bottom_marker
    result = ''.join([csproj_content_parts[0], imports, bottom_part])
    csproj.close()
    csproj = open(vs_templates_csproj_location, 'w', encoding="utf8")
    csproj.write(result)
    csproj.close()


def convert_template_files(template: Template):
    print('-----------------------------------------------------------------------------------------')
    print('Processing {0} template'.format(template.path))
    print('-----------------------------------------------------------------------------------------')
    processed_files = []
    if template.vs_template_path:
        if template.exclude_cs_files:
            processed_files.extend(convert_project_template(template.path, template.vs_template_path, False))
            processed_files.extend(convert_project_template(template.path, template.vs_template_path, True))
            return processed_files
        return convert_project_template(template.path, template.vs_template_path)
    elif template.sub_templates:
        for sub_template in template.sub_templates:
            sub_template_path = os.path.join(template.path, sub_template.path)
            processed_sub_files = convert_project_template(sub_template_path, sub_template.vs_template_path)
            processed_files.extend(processed_sub_files)
    return processed_files


if __name__ == '__main__':
    for cli_template in templates_map:
        converted_files = convert_template_files(cli_template)
        sync_csproj(converted_files, cli_template.path)
