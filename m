From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 00/15] Trivial sparse patches
Date: Mon, 15 Dec 2008 03:25:43 +0300
Message-ID: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63676 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbYLOAQc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:16:32 -0500
Received: by bwz14 with SMTP id 14so1154922bwz.13
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:16:30 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

Hello.

Here are a few sparse patches that I have collected
from the mailing list and from my own repository
and that I consider either trivial or harmless.
There is an other series that might require some
more review/discussion, which I'll send later.

You can pull the patches from brahch 'trivial' of
git://git.zaytsev.su/git/sparse.git

Please check that everything is correct and that
all theese patches are still intended for mainline
inclusion.

Also, we need sign-offs for theese patches:
David Given (2):
      Add type information to struct instruction.
      Unhardcode byte size being 8 bits.
---

Alexey Zaytsev (9):
      Warning should be enough for an unhandled transparent union
      A slightly edited irc discussion with Josh Triplett.
      Gdb macros to get a better look at some sparse data structures.
      Handle missing argument to -D.
      Mark handle_switch as static and don't export it from lib.h
      Looks more evident this way.
      Handle a terminal -o option properly.
      Make show_symbol newline-consistent
      Replace the -specs cgcc option with -target

Blue Swirl (2):
      OpenBSD support
      Sparc64 (Sparc V9, LP64) support

Christopher Li (2):
      Remove pre_buffer
      Evaluate iterator symbols

David Given (2):
      Add type information to struct instruction.
      Unhardcode byte size being 8 bits.


 Documentation/data-structures.txt |   54 ++++++
 Makefile                          |   20 +-
 cgcc                              |   12 +
 compat-bsd.c                      |   20 ++
 compile-i386.c                    |    2 
 evaluate.c                        |   27 ++-
 example.c                         |    2 
 expand.c                          |    2 
 flow.c                            |   10 +
 gdbhelpers                        |  310 +++++++++++++++++++++++++++++++++++++
 lib.c                             |   40 +++--
 lib.h                             |    1 
 linearize.c                       |    4 
 linearize.h                       |    1 
 parse.c                           |    2 
 show-parse.c                      |    9 +
 symbol.c                          |   12 +
 target.h                          |   10 +
 token.h                           |    2 
 tokenize.c                        |   21 +--
 20 files changed, 494 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/data-structures.txt
 create mode 100644 compat-bsd.c
 create mode 100644 gdbhelpers

--
