From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Mon, 25 Jun 2007 00:07:15 +0100
Message-ID: <20070624230715.GF21478@ftp.linux.org.uk>
References: <E1I2N6V-0003g9-8H@ZenIV.linux.org.uk> <20070624174732.GZ21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241102160.3593@woody.linux-foundation.org> <20070624183547.GA21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org> <1a25667a20e43a072f733a3ec2b8e79d@kernel.crashing.org> <20070624203837.GE21478@ftp.linux.org.uk> <20070624214253.GL7590@daikokuya.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:51816 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbXFXXHR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 19:07:17 -0400
Content-Disposition: inline
In-Reply-To: <20070624214253.GL7590@daikokuya.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Neil Booth <neil@daikokuya.co.uk>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Mon, Jun 25, 2007 at 06:42:53AM +0900, Neil Booth wrote:
> > such a big deal...  Parser would need to accept
> > 	ident ( \[ expr \] | . ident )*
> 
> don't forget -> if you're going to accept extra stuff.  GCC forgot ->
> with the parser rewrite, yes I filed a PR.

In offsetof() second argument???  Ah, hell...  You mean the situations
like offsetof(struct foo, x->a) in
struct foo {
	struct {
		int a;
	} x[10];
};

OK...
