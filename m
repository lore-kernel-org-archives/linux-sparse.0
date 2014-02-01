From: Josh Triplett <josh@joshtriplett.org>
Subject: __attribute__((force)) should not be a storage class
Date: Sat, 1 Feb 2014 10:49:35 -0800
Message-ID: <20140201184935.GA12321@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:60471 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbaBASwQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Feb 2014 13:52:16 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id D124A47AEC2
	for <linux-sparse@vger.kernel.org>; Sat,  1 Feb 2014 19:49:58 +0100 (CET)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Al Viro <viro@ftp.linux.org.uk>

Commit 3829c4d8b097776e6b3472290a9fae08a705ab7a ("Don't mix storage
class bits with ctype->modifiers while parsing type") in 2009 separated
storage classes from modifiers; in the process, it changed
__attribute__((force)) from a modifier to a storage class.  I don't
think it makes sense to have force as a storage class, for one critical
reason: storage classes are mutually exclusive.

$ cat /tmp/test.c
static __attribute__((force)) int *p;
static int q = *p;
$ ./sparse /tmp/test.c
/tmp/test.c:1:28: error: multiple storage classes

Given this, I think force should become a modifier again.  Any
objections?

- Josh Triplett
