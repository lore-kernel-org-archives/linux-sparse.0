From: =?UTF-8?B?SmFjZWsgxZpsaXdlcnNraQ==?= <sliwers@googlemail.com>
Subject: Re: Defect in linearization of short circuit &&
Date: Tue, 16 Feb 2010 20:19:59 +0100
Message-ID: <4B7AEFDF.3000608@googlemail.com>
References: <4B77FD0F.50401@googlemail.com> <4B78655D.2080007@googlemail.com>	 <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>	 <4B799CA6.70807@googlemail.com>	 <70318cbf1002151141p35e49f92l73510d09452f56ee@mail.gmail.com>	 <4B79AC03.4010608@googlemail.com>	 <70318cbf1002151311g103dbc27q3b89ae9804747684@mail.gmail.com>	 <1266312482.3433.33.camel@thorin> <70318cbf1002161102n63995222o914299dd358f594d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:43157 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932757Ab0BPTUF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Feb 2010 14:20:05 -0500
Received: by ewy8 with SMTP id 8so7278348ewy.29
        for <linux-sparse@vger.kernel.org>; Tue, 16 Feb 2010 11:20:03 -0800 (PST)
In-Reply-To: <70318cbf1002161102n63995222o914299dd358f594d@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

I understand your point and I agree that the optimization might make 
sense.  The problem is that my version of sparse gives different results.

parser_check:
.L0xb7ef00ac:
	<entry-point>
	br          %arg1, .L0xb7ef019c, ****.L0xb7ef014c****

.L0xb7ef019c:
	load.32     %r3 <- 4[%arg1]
	br          %r3, .L0xb7ef0124, .L0xb7ef014c

.L0xb7ef0124:
	phisrc.1    %phi1 <- $0
	br          .L0xb7ef0174

****.L0xb7ef014c:****
	load.32     %r5 <- 0[%arg1]
	setgt.32    %r7 <- %r5, %arg2
	phisrc.1    %phi2 <- %r7
	br          .L0xb7ef0174

.L0xb7ef0174:
	phi.1       %r8 <- %phi1, %phi2
	setgt.32    %r10 <- %arg2, $0
	and-bool.1  %r11 <- %r8, %r10
	br          %r11, .L0xb7ef00d4, .L0xb7ef00fc

.L0xb7ef00d4:
	call        execute_a, %arg1, %arg2
	br          .L0xb7ef01c4

.L0xb7ef00fc:
	call        execute_b, %arg1
	br          .L0xb7ef01c4

.L0xb7ef01c4:
	ret

Above, you can see that the execution will segfault within the label 
.L0xb7ef014c, on load 0[%arg1].

So my question is: do you have any code that is not committed to 
git.kernel.org?

Jacek
