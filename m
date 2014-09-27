From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 06/10] don't run sparse{c,i} tests when sparse-llvm is
 disabled
Date: Sat, 27 Sep 2014 14:37:27 +0100
Message-ID: <5426BD97.2080700@ramsay1.demon.co.uk>
References: <53DFD320.2050903@ramsay1.demon.co.uk> <CANeU7QkFPTW04ECjrJKHO51g38R6r3Rt8jX74PsAnEgpxRqxYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:45358 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751890AbaI0Nhc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Sep 2014 09:37:32 -0400
In-Reply-To: <CANeU7QkFPTW04ECjrJKHO51g38R6r3Rt8jX74PsAnEgpxRqxYw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 27/09/14 05:29, Christopher Li wrote:
> On Tue, Aug 5, 2014 at 2:38 AM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>> +if [ ! -x "$default_path/sparse-llvm" ]; then
>> +       disabled_cmds="sparsec sparsei sparse-llvm"
>> +fi
> 
> I think this can  be simplified as if the test command was not found,
> then that test will be disabled. It doesn't need to be sparse llvm, it
> can be other
> test program.

Unfortunately, sparcec and sparsei are the commands that are
used by the tests (I included sparse-llvm in the list in case
any _future_ tests used it directly), and they do exist and
are executable. They simply will not work if sparse-llvm is
not built.

I did think about removing the x-bit on sparse{c,i} in git,
enabling it again in the worktree if sparse-llvm was built,
but I was concerned that would not work on cygwin and it
would possibly complicate installation. ie I didn't try it
out seriously. This patch seemed the best solution to me.

[Another idea I didn't try: name the sparse{c,i} scripts
sparse{c,i}-in and rename them as part of a successful
build of sparse-llvm]

BTW, the 'validation/backend/sum.c' fails for me on cygwin
(64-bit), but I think it is actually a problem with the
llvm interpreter lli. (it works fine on my old 32-bit Linux
laptop).

ATB,
Ramsay Jones



