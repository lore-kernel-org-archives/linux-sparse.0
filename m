From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Backend projects for Sparse
Date: Wed, 28 Nov 2007 12:27:46 -0800
Message-ID: <70318cbf0711281227n4f41fe88hef0ac9432102a563@mail.gmail.com>
References: <1196243580.474d3a7c9895b@mail.physics.auth.gr>
	 <70318cbf0711281053k6dc561c5ge540ccd99a6a922e@mail.gmail.com>
	 <474DC549.2030000@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:55011 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbXK1U1r (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 28 Nov 2007 15:27:47 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1340656rvb
        for <linux-sparse@vger.kernel.org>; Wed, 28 Nov 2007 12:27:46 -0800 (PST)
In-Reply-To: <474DC549.2030000@garzik.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: nkavv@physics.auth.gr, linux-sparse@vger.kernel.org

On Nov 28, 2007 11:45 AM, Jeff Garzik <jeff@garzik.org> wrote:
> Christopher Li wrote:
> > It does not use the linearized byte code at all. The compile.c written by Linus
> > is a better place to start.
>
> test-linearize.c maybe?  compile.c is part of compile-i386.

Ah, you are right. I mix it up. It should be the "example.c" instead.
test-linearize.c just print out the linearized byte codes.

Chris
