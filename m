From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC PATCH 0/2] check for identical exprs on LHS and RHS of '&&'
Date: Wed, 10 Aug 2011 18:46:15 +0100
Message-ID: <20110810174615.GO2203@ZenIV.linux.org.uk>
References: <1312967235-23817-1-git-send-email-chrisf@ijw.co.nz>
 <20110810174423.GA6677@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:47288 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409Ab1HJRqT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Aug 2011 13:46:19 -0400
Content-Disposition: inline
In-Reply-To: <20110810174423.GA6677@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Chris Forbes <chrisf@ijw.co.nz>, linux-sparse@vger.kernel.org

On Wed, Aug 10, 2011 at 10:44:23AM -0700, Josh Triplett wrote:

> How about checking for the same expression multiple times in a single
> block of | or & expressions?  (flag1 | flag2 | flag2) seems like a
> likely copy/paste error.

... or result of macro expansion.
