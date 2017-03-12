From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Trying to understand linearized output
Date: Sun, 12 Mar 2017 20:27:38 +0100
Message-ID: <20170312192736.ds7k7jjiapoilir2@macpro.local>
References: <CACXZuxfTBH2hr8kOXepJ7VGCrfvjMU3h8GhDfZhtPEA6Ynw6jA@mail.gmail.com>
 <20170312171021.ivhh2fjyyj3xcgb5@macpro.local>
 <CACXZuxdX3ANytHJ+MPEm9gqcV0D8wJt7cWq4vSVkU7ffmDHFuw@mail.gmail.com>
 <20170312172050.24fwpfamwb3iivru@macpro.local>
 <CACXZuxdevCRT1VNrPRC1VXSH5nHQj17F9aPpDHOQU++Uu_384A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34870 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934858AbdCLT1m (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 15:27:42 -0400
Received: by mail-wm0-f54.google.com with SMTP id v186so27016062wmd.0
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 12:27:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxdevCRT1VNrPRC1VXSH5nHQj17F9aPpDHOQU++Uu_384A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 12, 2017 at 06:00:33PM +0000, Dibyendu Majumdar wrote:
> I got confused by the numbering initially as I was expecting all
> pseudos within a single function to be numbered sequentially.

Yes.
I think they should, but in normal circonstances it doesn't matter.

> So I should just read following :
> 
> phisrc.64   %phi98(current) <- %r333
> 
> As:
> 
> %phi98(current) = %r333
> 
> And 98 just happens to be the identifier for the pseudo, and 'phi' is
> just to help the reader know that the value will go into a phi
> instruction later. Is that correct?

Absolutely.

-- Luc
