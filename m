From: Christopher Li <sparse@chrisli.org>
Subject: sparse 2.4.3-rc1
Date: Fri, 8 Oct 2010 16:54:37 -0700
Message-ID: <AANLkTin4yz3GdHQiWGJZ8yoVTvJbn6CpTzE7y=t868cr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65437 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab0JHXyi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Oct 2010 19:54:38 -0400
Received: by iwn6 with SMTP id 6so909289iwn.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Oct 2010 16:54:37 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

It is about time to get another sparse release.
Mostly small fix up. Some help to reduce the noise level on recent
kernel checking.

For people interested in the sparse internals, there is a sparse inspecting
tools now. Currently it has limited knowledge of AST. It is very easy to
extent though.

Give it a try and report back any problem you have.

Chris

--

Bernd Petrovitsch (1):
      Fix a typo - "typdef" is neither C nor plain English

Christopher (3):
      evaluate: check for NULL type inside typeof
      Add test case for builtin_unreachable()
      inspect: add some expression inspection

Christopher Li (15):
      Make MOD_NORETURN fits into 32 bit
      Move noreturn attribute out of ignore attr area
      Declare ignored attributres into a list of string.
      Simplify Makefile using static pattern rules
      Adding test case for "x && y && z" .
      Pointer don't inherent the alignment from base type
      Allow parsing L'\0'
      Parsing wide char string
      Adding asm goto label test case
      inspect: add custom ast treeview model
      inspect: add some example inspect for symbol and statement
      inspect: Add test-inspect program
      inspect: cast expression
      Fixup and cleanup modifier_string() function.
      sparse 4.2.3-rc1

Damien Lespiau (1):
      Ignore the may_alias GCC attribute

Dan Carpenter (1):
      add test-inspect to .gitignore

Dan McGee (1):
      Makefile: fix permissions mixup on install

Daniel De Graaf (1):
      Fix incorrect linearization of "x && y && z"

Jiri Slaby (3):
      parser: add support for asm goto
      parser: fix and simplify support of asm goto
      parser: define __builtin_unreachable

Joel Soete (1):
      possible fix to cgcc issue in sparse 0.4.2:

Josh Triplett (2):
      Rename -Wall to Wsparse-all, so it doesn't get turned on unintentionally
      New attribute designated_init: mark a struct as requiring designated init

Kamil Dudka (1):
      do not ignore attribute 'noreturn'...

Michael Buesch (2):
      ignore attributes "externally_visible" and "signal"
      Ignore "naked" attribute

Michael Stefaniuc (3):
      Ignore the ms_abi/sysv_abi attributes.
      Ignore the alloc_size attribute.
      Handle __builtin_ms_va_list.

Mike Frysinger (1):
      parser: add Blackfin gcc info

Morten Welinder (1):
      skip may_alias and declare builtin_fabs
