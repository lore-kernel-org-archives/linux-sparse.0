From: Bryan O'Sullivan <bos@serpentine.com>
Subject: Re: Try to teach sparse about construct like 'struct
	__attribute__((foo)) bar'
Date: Tue, 17 Jan 2006 17:05:15 -0800
Message-ID: <1137546315.4757.20.camel@serpentine.pathscale.com>
References: <20060118003942.GA1419@ralph05.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx.pathscale.com ([64.160.42.68]:41685 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932318AbWARBFU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Jan 2006 20:05:20 -0500
In-Reply-To: <20060118003942.GA1419@ralph05.lan>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>
Cc: linux-sparse@vger.kernel.org

On Wed, 2006-01-18 at 01:39 +0100, Luc Van Oostenryck wrote:
> On the current linux git tree, sparse spit a lot of errors:
> 	include/asm/lppaca.h:34:8: error: Trying to use reserved word '__attribute__' as identifier
> 
> which is caused by a declaration:
> 	struct __attribute__((__aligned__(0x400))) lppaca {

Funny, I just posted a patch to lkml regarding this.  It'll be in the
next -mm patch.

	<b

