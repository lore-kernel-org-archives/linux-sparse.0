From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: Detect unused header files?
Date: Thu, 30 Jul 2009 12:12:31 +0100
Message-ID: <4A71801F.9060001@knosof.co.uk>
References: <20090728181803.GA20845@merkur.ravnborg.org>	 <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>	 <alpine.LFD.2.00.0907281634400.3974@localhost>	 <70318cbf0907281349k72a71b8fyc10d80992e4b1db9@mail.gmail.com>	 <20090728210404.GA21187@merkur.ravnborg.org>	 <70318cbf0907281438i876e21fja037aed7169aa8bf@mail.gmail.com> <70318cbf0907300355h5cb34671ha452433c4e0b5324@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from queueout03-winn.ispmail.ntl.com ([81.103.221.33]:27801 "EHLO
	queueout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752686AbZG3LVV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Jul 2009 07:21:21 -0400
In-Reply-To: <70318cbf0907300355h5cb34671ha452433c4e0b5324@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, "Robert P. J. Day" <rpjday@crashcourse.ca>, sparse <linux-sparse@vger.kernel.org>

Christopher,

> I create a branch "unused-include-files" for some experiment patch.
> Some thing quick and dirty to find out what works and what doesn't.
> No where near submitting quality.

Sorry I meant to post earlier.  Projects typically contain around 30%
of unused headers.  References to various research articles available
in: c0x.coding-guidelines.com/6.10.2.pdf

-- 
Derek M. Jones                         tel: +44 (0) 1252 520 667
Knowledge Software Ltd                 mailto:derek@knosof.co.uk
Source code analysis                   http://www.knosof.co.uk
