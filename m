From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] arm64: pass machine size to sparse
Date: Wed, 21 Jun 2017 18:54:32 +0200
Message-ID: <20170621165431.lmcwohnxkncgpevs@ltop.local>
References: <20170620122443.35880-1-luc.vanoostenryck@gmail.com>
 <20170620154938.GH21131@arm.com>
 <20170620162431.zi6qd3jby7shyu46@ltop.local>
 <20170620170401.GA28035@arm.com>
 <20170620190739.ijtpo3ekibxi47qj@ltop.local>
 <20170621161254.GF6041@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35319 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdFUQyf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Jun 2017 12:54:35 -0400
Received: by mail-qk0-f194.google.com with SMTP id 16so11183878qkg.2
        for <linux-sparse@vger.kernel.org>; Wed, 21 Jun 2017 09:54:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170621161254.GF6041@arm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org

On Wed, Jun 21, 2017 at 05:12:54PM +0100, Will Deacon wrote:
> On Tue, Jun 20, 2017 at 09:07:40PM +0200, Luc Van Oostenryck wrote:
> > Well, currently sparse is arch agnostic and I think it's a good thing.
> > For the few arch specifities you have to use some of the '-m' flags
> > (like -m32/-m64, -msize-long). So, for the moment the '-m64' flag
> > is needed, thus the patch.
> 
> Ok, I'll pick your patch up then. The endianness case is more interesting,
> because I don't think __BIG_ENDIAN__ and __LITTLE_ENDIAN__ are the defines
> to use; the kernel seems to omit the trailing underscores afaict.

I just checked, it's a bit messy.
The kernel seems to rely, at least partly, maybe mostly, on
CONFIG_CPU_{BIG,LITTLE}_ENDIAN and then __{BIG,LITTLE}_ENDIAN is
defined via include/uapi/linux/byteorder/{big,little}_endian.h

Otherwise, from the compiler side it seems that __BYTE_ORDER__ &
__ORDER_{BIG,LITTLE}_ENDIAN__ is defined consistently.
But, for example for arm64, 'gcc -mlittle-endian' gives
	#define __LITTLE_ENDIAN__ 1
while 'gcc -mbig-endian' doesn't define __BIG_ENDIAN__ but
	#define __ARM_BIG_ENDIAN 1

*shrugh*

I've added support for the -m{big,little}-endian flag to sparse
but it seems it will be more complicated for the defines.

-- Luc
