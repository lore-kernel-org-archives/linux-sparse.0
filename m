From: Christopher Li <sparse@chrisli.org>
Subject: Sparse 0.4.4 is released
Date: Fri, 25 Nov 2011 13:13:33 -0800
Message-ID: <CANeU7Qn9GcQhX8bB43ivpQFfYHvbuQ73XZhsTfoiq6MO=g3+vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59083 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab1KYVNe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Nov 2011 16:13:34 -0500
Received: by faas1 with SMTP id s1so2377170faa.19
        for <linux-sparse@vger.kernel.org>; Fri, 25 Nov 2011 13:13:33 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: lwn@lwn.net, Josh Triplett <josh@joshtriplett.org>, Dan Carpenter <error27@gmail.com>

This is a long due release. The sparse 0.4.4 can be downloaded from:

http://www.kernel.org/pub/software/devel/sparse/dist/

The new sparse has a lot of bugs fixes. It will report less noise
while checking the new kernel tree. It compiles better with the
new gcc as well.

The sparse project is in the process of moving to the MIT license.
Dan is coordinating the efforts. Most sparse developers sign off
the MIT license already. If you haven't done so, please contact
Dan off the list regarding the new license.

Here is the short summery of the changes in this release.

Have a nice long week end.

Chris


Ben Pfaff (1):
      evaluate: Allow sizeof(_Bool) to succeed.

Christopher Li (13):
      inspect: adding function arugument list
      Allow overwrite CFLAGS from command line
      Ignore attribute vector_size
      Remove set but not used variable
      inspect: Add switch statement and more
      validation: inline switch statement
      Fix inlining switch statement.
      Sparse 0.4.4-rc1
      Add test case for empty asm clobbers
      Fix parsing empty asm clobber
      Sparse 0.4.4-rc2
      Add test case for binary constants
      sparse 0.4.4

Dan Carpenter (1):
      recognize binary constants

Diego Elio Petten=F2 (3):
      build: allow easy override of GCC_BASE
      build: add an all-installable target that builds the targets to i=
nstall.
      Fix build with GCC 4.6 series.

=46lorian Fainelli (1):
      Makefile: warn user when libxml and/or libgtk2 are not available

Jan Pokorn=FD (4):
      remove unused "container" macro
      flow.c: make comment for `dominates' reflect code
      use ARRAY_SIZE() when possible (continued)
      parse.c: "if(" -> "if (" adjustment

Jonathan Neusch=E4fer (3):
      fix a memory leak in compile-i386.c
      FAQ: fix a typo ("because or")
      fix common misspellings with codespell

Kamil Dudka (2):
      cse: treat PHI-nodes as other instructions
      cse: update PHI users when throwing away an instruction

Linus Torvalds (5):
      Add new streams to a hash-list based on their names
      Teach 'already_tokenized()' to use the stream name hash table
      Make 'linearize_iterator()' helper function
      Make 'linearize_switch()' helper function
      Make 'linearize_return()' helper function

Michael Stefaniuc (1):
      Ignore the ms_hook_prologue attribute.

Namhyung Kim (3):
      use ARRAY_SIZE() when possible
      Fix tokenizer for octal escape sequences
      Update the validation check for escape sequences

Nicolas Kaiser (1):
      memops.c: always true expression

Pekka Enberg (4):
      sparse: Add 'artifical' to ignore attributes
      sparse: Enable unhandled validation tests
      Show expected vs. actual output on test failure
      sparse: Fix __builtin_safe_p for pure and const functions
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
