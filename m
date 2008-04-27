From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 0/5] more sparse context tracking improvements
Date: Sun, 27 Apr 2008 13:31:28 +0200
Message-ID: <20080427113128.237957000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:46131 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762372AbYD0LyW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 27 Apr 2008 07:54:22 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>

These patches make further changes to the contex tracking:
 1) add __exact_context__
 2) allow context() attribute on variables
 3) evaluate/expand context expressions
 4) revert the conditional_context patch
 5) check context expressions as expressions

The changes are described in more detail within the patches.

johannes
