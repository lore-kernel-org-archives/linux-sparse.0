From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: Using c2xml on kernel sources
Date: Tue, 20 Mar 2012 10:32:51 +0100
Message-ID: <1332235972.21661.65.camel@thorin>
References: <CABG-yt06Kw2uFnmrshcHYjgf_cMgzKVdMPe6BXOP2nryhRjBpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:2552 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755399Ab2CTJvs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 20 Mar 2012 05:51:48 -0400
In-Reply-To: <CABG-yt06Kw2uFnmrshcHYjgf_cMgzKVdMPe6BXOP2nryhRjBpg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Shakthi Kannan <shakthimaan@gmail.com>
Cc: linux-sparse@vger.kernel.org

Hi!
On Die, 2012-03-20 at 14:30 +0530, Shakthi Kannan wrote:
[...]
> I would like to run c2xml on the Linux kernel sources. Is there a
> recommended way of using the tool on kernel code?
> 
> I tried running it directly on a source file, but, get the
> 'header-file "unable to open" error.
> 
>   $ c2xml linux-3.0.4/net/ethernet/eth.c
> 
>   ../linux-3.0.4/net/ethernet/eth.c:40:11: error: unable to open
> 'linux/module.h'
> 
> I have built sparse from git sources (v0.4.4) on Fedora 15 x86_64.

Someone probably have to tell c2xml where to look for the .h files
similar to gcc's "-I" parameters.

	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at

