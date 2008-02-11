From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: preprocess(), external_declaration(),  writing a "smart" editor
Date: Mon, 11 Feb 2008 20:16:00 +0300
Message-ID: <20080211171600.GA1148@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from x346.tv-sign.ru ([89.108.83.215]:32941 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743AbYBKRtI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Feb 2008 12:49:08 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Reza Roboubi <reza@earthdetails.com>
Cc: linux-sparse@vger.kernel.org

Reza Roboubi wrote:
>
> Consider an editor that can do search & replace for all instances of
> 'size', but only when 'size' is a member of 'struct list'.  (Even
> if 'size' is being referenced from inside a macro.)
>
> I've glanced at the source code.  Can you help me find out if sparse is
> right for this?

You can look at dissect.c. There is no documentation, please read the changelog
in http://git.kernel.org/?p=devel/sparse/sparse.git;a=commit;h=c6e90aa8eb9c0b32a771428aff9f2aff2e9bbd9d

->r_member() reports the usage of struct's members, see also test-dissect.c

Oleg.
