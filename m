From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: smatch/sparse complaints on static assertion
Date: Wed, 12 Feb 2020 01:31:28 +0100
Message-ID: <20200212003128.pieng2rlw7mykhvk@ltop.local>
References: <e588417e-1bf4-35e3-d8d9-9911fe29e0f5@pensando.io>
 <ecdd10cb-0022-8f8a-ec36-9d51b3ae85ee@pensando.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f45.google.com ([209.85.221.45]:37938 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgBLAbc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Feb 2020 19:31:32 -0500
Received: by mail-wr1-f45.google.com with SMTP id y17so63643wrh.5
        for <linux-sparse@vger.kernel.org>; Tue, 11 Feb 2020 16:31:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ecdd10cb-0022-8f8a-ec36-9d51b3ae85ee@pensando.io>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Shannon Nelson <snelson@pensando.io>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Tue, Feb 11, 2020 at 09:41:05AM -0800, Shannon Nelson wrote:
> Hi All,
> 
> I'm getting complaints from smatch on the ionic network driver's static
> assertions and am not sure why it was complaining.  Dan Carpenter suggested
> this might be an issue in sparse with how it is calculating the sizes of the
> unions.
> 
> I ran this at the top of a pretty recent net-next tree
> (v5.5-rc7-1839-g8192c36)
> $ ../smatch/smatch_scripts/kchecker drivers/net/ethernet/pensando/ionic/
> 
> And got several copies of this:
> 
> drivers/net/ethernet/pensando/ionic/ionic_dev.h:38:1: error: static
> assertion failed: "sizeof(union ionic_dev_regs) == 4096"

...
 
> These static assertion lines have been fine up until now and I'm pretty sure
> they are correct.
> 
> Has this issue been seen elsewhere?  Or is there something I can do in our
> code to get rid of the complaints?

This is caused by the packing of the structs. It's using
	#pragma pack(push, 1) / #pragma pack(pop)
which is not supported by Sparse. Packing via __attribute__((packed))
is incomplete but the pragmas are currently completly ignored.

-- Luc Van Oostenryck
