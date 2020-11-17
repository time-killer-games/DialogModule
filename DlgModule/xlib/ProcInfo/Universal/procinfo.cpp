﻿/*

 MIT License
 
 Copyright © 2020 Samuel Venable
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
*/

#include <cstddef>
#include <algorithm>
#include <sstream>
#include <thread>

#include "../procinfo.h"

using std::string;
using std::vector;
using std::size_t;
using std::thread;

bool string_has_whitespace(string str) {
  return str.find_first_of("\t\r\n ") != string::npos;
}

vector<string> string_split_by_first_equalssign(string str) {
  size_t pos = 0;
  vector<string> vec;
  if ((pos = str.find_first_of("=")) != string::npos) {
    vec.push_back(str.substr(0, pos));
    vec.push_back(str.substr(pos + 1));
  }
  return vec;
}

vector<string> string_split(string str, string delimiter) {
  vector<std::string> vec;
  std::stringstream sstr(str);
  string tmp;
  while (std::getline(sstr, tmp, delimiter[0]))
    vec.push_back(tmp);
  return vec;
}

namespace procinfo {

void process_execute_async(process_t ind, string command) {
  thread proc_thread(process_execute, ind, command);
  proc_thread.detach();
}

string dir_from_pid(process_t pid) {
  string fname = path_from_pid(pid);
  size_t fp = fname.find_last_of("/\\");
  return fname.substr(0, fp + 1);
}

string name_from_pid(process_t pid) {
  string fname = path_from_pid(pid);
  size_t fp = fname.find_last_of("/\\");
  return fname.substr(fp + 1);
}

string env_from_pid_ext(process_t pid, string name) {
  string env = ""; vector<string> newlinesplit = string_split(env_from_pid(pid), "\n");
  for (size_t i = 0; i < newlinesplit.size(); i++) {
    vector<string> equalssplit = string_split_by_first_equalssign(newlinesplit[i]);
    for (size_t j = 0; j < equalssplit.size(); j++) {
      std::transform(equalssplit[0].begin(), equalssplit[0].end(), equalssplit[0].begin(), ::toupper);
      std::transform(name.begin(), name.end(), name.begin(), ::toupper);
      if (j == 1 && equalssplit[0] == name) {
        equalssplit[j] = string_replace_all(equalssplit[j], "\"", "");
        equalssplit[j] = string_replace_all(equalssplit[j], "\\\"", "\"");
        env = equalssplit[j];
      }
    }
  }
  return env;
}

} // namespace procinfo

