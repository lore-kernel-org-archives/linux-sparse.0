From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 00/10] misc sparse patches
Date: Sun, 17 Aug 2014 15:53:12 +0100
Message-ID: <53F0C1D8.1060408@ramsay1.demon.co.uk>
References: <53DFD19B.1090201@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:36885 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751351AbaHQOxQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 17 Aug 2014 10:53:16 -0400
In-Reply-To: <53DFD19B.1090201@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 04/08/14 19:31, Ramsay Jones wrote:
> 
> Hi Chris,
> 
> I have collected quite a few sparse patches, some of which are
> very old (e.g. patch #1 is from 2009), so it's about time I at
> least tried to get them upstream! This represents the subset of
> patches which I think are useful/ready (the MinGW patches are
> still on the back-burner!). ;-)
> 
> Some short notes on the patches:
> 
>   01. Add the __restrict__ keyword
>   02. sparse: add 'gnu_inline' to the ignored attributes
> 

Did you have any more comments on these patches, or any of the
other patches below? Is there anything else you need me to do
to progress this series (well, minus the RFC #10, maybe).

ATB,
Ramsay Jones

> These patches fix up features that are used in system header
> files, on certain platforms, which usually renders sparse
> completely useless if you #include such a system header.
> 
>   03. don't call isdigit/tolower with a char argument
>   04. compile-i386.c: don't mix calls to write(2) with stdio
> 
> These fix up some compiler warnings. See patch #4 for some
> further notes.
> 
>   05. Makefile: suppress error message from shell
>   06. don't run sparse{c,i} tests when sparse-llvm is disabled
> 
> If you don't have LLVM installed, the test suite spews many
> test failures for programs that haven't been built, which
> obscures test failures for sparse itself. These patches provide
> a means to silence the useless test failures.
> 
>   07. Add support for multiarch system header files
>   08. cgcc: use only the cc command to determine $gcc_base_dir
>   09. cgcc: use $ccom to set $multiarch_dir if not specified
> 
> A couple of years ago, after upgrading my Linux installation,
> I found that gcc was now using 'multiarch' directories for
> various files. This caused a problem, in particular, with
> the system include files. For example, this meant that I had
> to add '-isystem /usr/include/i386-linux-gnu' to SPARSE_FLAGS
> in my config.mak file in git.git to make things work again.
> These patches provide support for 'multiarch' systems in
> sparse directly, which actually fixes some (4) tests which
> include some system headers.
> 
>   10. cgcc: add a configuration file for cgcc
> 
> Unlike the previous patches, this one is brand new and marked
> as RFC. When I added patch #9 I noticed a marked slowdown on
> cygwin. A few days ago, I finally decided to have a look at this
> to see if I could improve the performance on cygwin. This patch
> not only clawed back the time lost by patch #9, but it improved
> the performance even further (by about 20%).
> 
> ATB,
> Ramsay Jones
> 
> 
> Ramsay Jones (10):
>   Add the __restrict__ keyword
>   sparse: add 'gnu_inline' to the ignored attributes
>   don't call isdigit/tolower with a char argument
>   compile-i386.c: don't mix calls to write(2) with stdio
>   Makefile: suppress error message from shell
>   don't run sparse{c,i} tests when sparse-llvm is disabled
>   Add support for multiarch system header files
>   cgcc: use only the cc command to determine $gcc_base_dir
>   cgcc: use $ccom to set $multiarch_dir if not specified
>   cgcc: add a configuration file for cgcc
> 
>  Makefile                 | 19 ++++++++++---------
>  cgcc                     | 23 +++++++++++++++++++++--
>  compile-i386.c           |  7 ++-----
>  expression.c             |  2 +-
>  ident-list.h             |  2 +-
>  lib.c                    | 22 +++++++++++++++++++---
>  parse.c                  |  5 ++++-
>  sparse.1                 |  6 ++++++
>  validation/attr-inline.c | 21 +++++++++++++++++++++
>  validation/reserved.c    |  1 +
>  validation/test-suite    | 25 +++++++++++++++++++++++--
>  11 files changed, 109 insertions(+), 24 deletions(-)
>  create mode 100644 validation/attr-inline.c
> 

