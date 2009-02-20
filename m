From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Declarations with typedef (Was: Re: Messing typedefs?)
Date: Fri, 20 Feb 2009 11:00:16 +0100
Message-ID: <OF43E68700.A0BC8190-ONC1257563.00349412-C1257563.0036E79A@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:49656 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZBTJ7z (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Feb 2009 04:59:55 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

The old thread "Messing typedefs" 
(http://marc.info/?l=linux-sparse&m=118156319806264) described strange 
behaviour:

>         typedef unsigned char  plcbit;
>         typedef unsigned char  USINT;
> 
>         USINT usVar1;
> 
> leads to a symbol "usVar1" with base_type->ident named "plcbit".

This has changed, but now I can't find any information inside symbol "
usVar1" that points to the used typedef .

How am I able to get the typedef a symbol is declared with - if it is 
declared with one?
Is there a way?

Greetings
Thomas Schmid


