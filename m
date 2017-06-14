From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: MOD_TYPEDEF unused?
Date: Wed, 14 Jun 2017 03:54:23 +0200
Message-ID: <20170614015421.r4h6aqduav27hrod@ltop.local>
References: <CACXZuxcVHQrRNtKGS8mURVuHPUDhwsyF7AFnnvCBpbHb2AwQpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34460 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754147AbdFNBy3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 21:54:29 -0400
Received: by mail-wr0-f169.google.com with SMTP id 77so20326252wrb.1
        for <linux-sparse@vger.kernel.org>; Tue, 13 Jun 2017 18:54:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcVHQrRNtKGS8mURVuHPUDhwsyF7AFnnvCBpbHb2AwQpQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jun 13, 2017 at 11:01:15PM +0100, Dibyendu Majumdar wrote:
> Hi,
> 
> I was looking at the output of c2xml (actually modified version used
> in dmrC project) - and saw that typedefs are not marked in any way.
> Digging deeper I found that typedef symbols do not have the
> MOD_TYPEDEF set. MOD_USERTYPE is set though.
> 
> Is there any harm in setting MOD_TYPEDEF also?

Yes, MOD_TYPEDEF is not used and MOD_USERTYPE is used to 'mark'
typedefs.

I've a patch to tidy up this as well as other cleanups
of the MOD_XXXs. It will be part of the first batch of patches
after the release.

-- Luc
