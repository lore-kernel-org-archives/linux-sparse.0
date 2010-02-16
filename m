From: Christopher Li <sparse@chrisli.org>
Subject: Re: Defect in linearization of short circuit &&
Date: Tue, 16 Feb 2010 11:10:57 -0800
Message-ID: <70318cbf1002161110w6915f9c3g144f970fb969c913@mail.gmail.com>
References: <4B77FD0F.50401@googlemail.com> <4B78655D.2080007@googlemail.com>
	 <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>
	 <4B799CA6.70807@googlemail.com>
	 <70318cbf1002151141p35e49f92l73510d09452f56ee@mail.gmail.com>
	 <4B79AC03.4010608@googlemail.com>
	 <70318cbf1002151311g103dbc27q3b89ae9804747684@mail.gmail.com>
	 <1266312482.3433.33.camel@thorin>
	 <70318cbf1002161102n63995222o914299dd358f594d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f178.google.com ([209.85.221.178]:38872 "EHLO
	mail-qy0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909Ab0BPTK7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Feb 2010 14:10:59 -0500
Received: by qyk8 with SMTP id 8so1286758qyk.24
        for <linux-sparse@vger.kernel.org>; Tue, 16 Feb 2010 11:10:58 -0800 (PST)
In-Reply-To: <70318cbf1002161102n63995222o914299dd358f594d@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc: =?ISO-8859-2?Q?Jacek_=A6liwerski?= <sliwers@googlemail.com>, linux-sparse@vger.kernel.org

On Tue, Feb 16, 2010 at 11:02 AM, Christopher Li <sparse@chrisli.org> wrote:
> That is why this optimization is using a cost model. If the left hand

Sorry I mean right hand side here.

> side cost is lower than the branch instruction cost, and it is *safe* to
> do so. It turn the branch instruction into arithmetic instruction.

Chris
