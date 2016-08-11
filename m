From: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH v2 2/2] arm64: implement live patching
Date: Thu, 11 Aug 2016 18:46:03 +0200
Message-ID: <20160811164603.GA24751@lst.de>
References: <20160627151500.2247A68D20@newverein.lst.de> <20160627151722.B81C968D29@newverein.lst.de> <alpine.LNX.2.00.1607111556320.27989@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42440 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932763AbcHKQqG (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Aug 2016 12:46:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1607111556320.27989@pobox.suse.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Miroslav Benes <mbenes@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, takahiro.akashi@linaro.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Li Bin <huawei.libin@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, andrew.wafaa@arm.com, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, live-patching@vger.kernel.org, linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org, jeyu@redhat.com

On Mon, Jul 11, 2016 at 04:03:08PM +0200, Miroslav Benes wrote:
> On Mon, 27 Jun 2016, Torsten Duwe wrote:
> > +
> > +#ifdef CONFIG_LIVEPATCH
> 
> A nit but we removed such guards in the other header files.

I just notice this has fallen between the cracks :-/

	Torsten

