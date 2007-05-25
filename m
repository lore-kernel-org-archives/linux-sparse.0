From: Al Viro <viro@ftp.linux.org.uk>
Subject: comparison of safe pointers
Date: Fri, 25 May 2007 14:07:49 +0100
Message-ID: <20070525130749.GI4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34651 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbXEYNHu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 May 2007 09:07:50 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org

	Why do we generate a warning when we compare two pointers
declared as safe?  I understand why we do that when such beast gets
used as condition (i.e. implicitly compare with NULL), but what's
wrong with

int foo(void __safe *p, void __safe *q)
{
	return p == q;
}

What did you want that check in evaluate_compare() to catch?  Is that
about warning on explicit comparison with NULL?

Al, crawling through evaluate.c and fixing odd cases in typechecking...
