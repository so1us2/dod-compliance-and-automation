control "VCFL-67-000022" do
  title "vSphere Client must set the welcome-file node to a default web page."
  desc  "Enumeration techniques, such as URL parameter manipulation, rely upon
being able to obtain information about the web server's directory structure by
locating directories without default pages. In the scenario, the web server
will display to the user a listing of the files in the directory being
accessed. By having a default hosted application web page, the anonymous web
user will not obtain directory browsing information or an error message that
reveals the server type and version. Ensuring that every document directory has
an index.jsp (or equivalent) file is one approach to mitigating the
vulnerability."
  impact 0.5
  tag severity: "CAT II"
  tag gtitle: "SRG-APP-000266-WSR-000142"
  tag gid: nil
  tag rid: "VCFL-67-000022"
  tag stig_id: "VCFL-67-000022"
  tag cci: "CCI-001312"
  tag nist: ["SI-11 a", "Rev_4"]
  desc 'check', "At the command prompt, execute the following command:

# xmllint --format
/usr/lib/vmware-vsphere-client/server/configuration/conf/web.xml | sed
's/xmlns=\".*\"//g' | xmllint --xpath '/web-app/welcome-file-list' -

Expected result:

<welcome-file-list>
    <welcome-file>index.html</welcome-file>
    <welcome-file>index.htm</welcome-file>
    <welcome-file>index.jsp</welcome-file>
  </welcome-file-list>

If the output of the command does not match the expected result, this is a
finding."
  desc 'fix', "Navigate to and open
/usr/lib/vmware-vsphere-client/server/configuration/conf/web.xml

Inspect the file and ensure that it contains the below section:

<welcome-file-list>
    <welcome-file>index.html</welcome-file>
    <welcome-file>index.htm</welcome-file>
    <welcome-file>index.jsp</welcome-file>
  </welcome-file-list>"

  list = ["index.html", "index.htm", "index.jsp"]
  describe xml('//usr/lib/vmware-vsphere-client/server/configuration/conf/web.xml') do
    its('/web-app/welcome-file-list/welcome-file') { should be_in list }
  end

end