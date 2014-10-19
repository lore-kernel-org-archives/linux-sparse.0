From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/4] cgcc: avoid passing a sparse-only option to cc
Date: Sun, 19 Oct 2014 15:21:44 +0100
Message-ID: <5443C8F8.2000003@ramsay1.demon.co.uk>
References: <54398BA5.6050005@ramsay1.demon.co.uk>	<CANeU7QnOJTKK___Vb3VpN=_x62wVpS=A57UkTQrSz0-GYBF5rQ@mail.gmail.com>	<543EAFFA.6070503@ramsay1.demon.co.uk> <CANeU7Q=ruQhu19sY=mDyiBmyDCGRR+xmRE7SzN9BcGLRZWX8Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:34452 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751916AbaJSOVy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Oct 2014 10:21:54 -0400
In-Reply-To: <CANeU7Q=ruQhu19sY=mDyiBmyDCGRR+xmRE7SzN9BcGLRZWX8Bw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>

Sorry for the late reply, it's been a busy few days. ;-)

On 16/10/14 02:45, Christopher Li wrote:
> Hi,
> 
> I create a branch in the chrisl repo call "review-ramsay" for your new
> follow up patches.
> I plan to do incremental fix up if any on that branch. Then when we
> both happy about it,
> I will do rebase and smash the commit before push to master branch.

Yes, I noticed the new branch - thanks!

Did you have any thoughts regarding Josh Triplett's comments on the
"compile-i386.c: don't ignore return value of write(2)" patch?

> 
> 
> 
> On Thu, Oct 16, 2014 at 1:33 AM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>> On 15/10/14 15:23, Christopher Li wrote:
>>> On Sun, Oct 12, 2014 at 3:57 AM, Ramsay Jones
>>> <ramsay@ramsay1.demon.co.uk> wrote:
>>>>
>>>>
>>>> -       system ($check) == 0 or die;
>>>> +       system ($check) == 0 or exit 1;
>>>
>>> Why not exit with the error code from sparse here?
>>> Sparse might exit with other error code than "1" in the future.
>>
>> The meaning of the return value from system() is not portable.
> 
> I see. Does it mean we should use some thing other than "system".
> or maybe some thing like:
> 
> $retcode = system($check);
> if $retcode !=0 { exit $retcode; }

No, no, you don't want to do that even on Linux (let alone more
exotic platforms like Windows, MinGW and cygwin).

$ vim cgcc
$ git diff
diff --git a/cgcc b/cgcc
index 8e38174..364c77c 100755
--- a/cgcc
+++ b/cgcc
@@ -83,7 +83,9 @@ if ($do_check) {
 
     print "$check\n" if $verbose;
     if ($do_compile) {
-       system ($check) == 0 or exit 1;
+       my $code = system ($check);
+       print "code is: $code\n" ;
+       exit $code if $code != 0;
     } else {
        exec ($check);
     }
$ 

$ CHECK=./sparse ./cgcc hello.c
hello.c:3:5: warning: symbol 'f' was not declared. Should it be static?
code is: 0
$ echo $?
0
$ CHECK=./sparse ./cgcc -Wsparse-error hello.c
hello.c:3:5: error: symbol 'f' was not declared. Should it be static?
code is: 256
$ echo $?
0
$ 

Note that the 'return code' from ./sparse (1) is encoded in the 2nd
byte of $code. i.e. you have to 'interpret' the return from system
in a similar manner to a C program inspecting the status returned
by the wait() system call. (see the exit_code sub from the last
email, which included a right shift by 8 bits). Hmm, well, maybe!

It is often difficult, on many platforms, to determine if system()
will run the program directly using execvp or indirectly using a
system shell (and which one). There are various rules about this
issue which depends on the *form* of the call to system (is the
argument a simple scalar or an array) and if it is a scalar variable
does it contain any 'shell metacharacters'. (And even if it doesn't,
it still may use a shell anyway!)

$ CHECK=./junk ./cgcc -Wsparse-error hello.c
sh: 1: ./junk: not found
code is: 32512
$ echo $?
0
$ 

Note that 32512 == 0x7f00 which means the return code from the shell
was 127 which, according to the bash manpage means the command execution
failed due to 'command not found'. (This was actually an execution of
the dash shell, but I couldn't find the information in the dash manpage,
and it seems to follow bash, which in turn is following the original
bourne shell). ['man bash', then /EXIT<ret>].

It simply isn't worth the trouble ... :-D

[This all presupposes that we are happy to accept the change in behaviour
introduced by commit 4d881187 in the first place; i.e. not calling gcc if
'sparse' returns a non-zero status. ;-) ]

ATB,
Ramsay Jones


