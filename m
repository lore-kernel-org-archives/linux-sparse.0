From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] allow ifdef in macro arguments
Date: Sun, 21 Oct 2007 16:52:11 +0100
Message-ID: <20071021155211.GX8181@ftp.linux.org.uk>
References: <70318cbf0710210207t587f8d2enf024a56e1d10a5df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:52844 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbXJUPwQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 21 Oct 2007 11:52:16 -0400
Content-Disposition: inline
In-Reply-To: <70318cbf0710210207t587f8d2enf024a56e1d10a5df@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@freedesktop.org>

On Sun, Oct 21, 2007 at 02:07:15AM -0700, Christopher Li wrote:
> I think some one report it long time ago.

It should not accept those.  Undefined behaviour and if you try to actually
define the semantics for it, you run into such a pile of corner cases that
it's not worth even trying.
