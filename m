From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] allow ifdef in macro arguments
Date: Sun, 21 Oct 2007 11:18:33 +0200
Message-ID: <20071021091833.GB12794@ins.uni-bonn.de>
References: <70318cbf0710210207t587f8d2enf024a56e1d10a5df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from hermes.iam.uni-bonn.de ([131.220.223.5]:39170 "EHLO
	iam.uni-bonn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751306AbXJUJZR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 21 Oct 2007 05:25:17 -0400
Content-Disposition: inline
In-Reply-To: <70318cbf0710210207t587f8d2enf024a56e1d10a5df@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@freedesktop.org>

Hello Christopher,

* Christopher Li wrote on Sun, Oct 21, 2007 at 11:07:15AM CEST:
> I think some one report it long time ago.

FWIW, embedding directives within macro arguments is not portable
(warned by with gcc -pedantic), and causes undefined behavior according
to C99:6.10.3p11.

Cheers,
Ralf
