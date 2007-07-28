From: Al Viro <viro@ftp.linux.org.uk>
Subject: [git pull] misc fixes
Date: Sun, 29 Jul 2007 00:57:41 +0100
Message-ID: <20070728235741.GB21089@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:56778 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427AbXG1X5m (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 28 Jul 2007 19:57:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1IEwAH-0003DV-9D
	for linux-sparse@vger.kernel.org; Sun, 29 Jul 2007 00:57:41 +0100
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Please pull from git://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git
local15.

A bunch of bug fixes + more typechecking sanitized.

Contents:
      add __builtin_strlen()
      no such thing as array of functions
      new helper: unfoul()
      handling of typeof in evaluate_member_dereference()
      file and global scopes are the same for purposes of struct redefining
      ...,array should degenerate
      sanitize evaluate_ptr_add(), start checking for pointers to functions
      fix evaluate_compare()
      sanitize evaluate_postop()
      saner -Wtypesign
      braino in conditional_expression()
Diffstat:
 evaluate.c                    |  170 +++++++++++++++++++++++-----------------
 expression.c                  |    2 +-
 lib.c                         |    1 +
 parse.c                       |    2 +-
 scope.c                       |   10 +++
 scope.h                       |    1 +
 validation/comma.c            |   10 +++
 validation/member_of_typeof.c |   14 ++++
 validation/outer-scope.c      |   19 +++++
 9 files changed, 155 insertions(+), 74 deletions(-)
 create mode 100644 validation/comma.c
 create mode 100644 validation/member_of_typeof.c
 create mode 100644 validation/outer-scope.c
