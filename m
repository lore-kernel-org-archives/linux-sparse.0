From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 07/13] llvm: fix output OP_ADD mixed with pointers
Date: Mon, 6 Mar 2017 20:50:29 +0100
Message-ID: <20170306195028.zihiz2e34qdxjckg@macpro.local>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-8-luc.vanoostenryck@gmail.com>
 <CANeU7Qk6xjhNPVZWxTB4iOavH5=bha+a_utz7+PJuSTo1WKgOg@mail.gmail.com>
 <CACXZuxfX0TiYGJDewbRW9Tr3-nzqiBrdOK0K+mO0qqwyGCrjSQ@mail.gmail.com>
 <CANeU7Q=Y7mx501ZAvXesWCL_C92RsjQvFNJ_4dLvUeOg2chFhg@mail.gmail.com>
 <20170306164306.hibukuy2t4j4camh@macpro.local>
 <CACXZuxc3fDdh9OwKN4LGtEn=rf7rGe=GNn9Z_-3GevFa4yqWnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34881 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752935AbdCFTwJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 14:52:09 -0500
Received: by mail-wr0-f195.google.com with SMTP id u108so19105497wrb.2
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 11:50:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxc3fDdh9OwKN4LGtEn=rf7rGe=GNn9Z_-3GevFa4yqWnw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Mar 06, 2017 at 05:06:01PM +0000, Dibyendu Majumdar wrote:
> 
> This may be the issue Chris is highlighting -  above the offset should
> be 5 not 20 in the LLVM code as the array type is i32* not i8*. Does
> sparse always output array offsets in char*?

Yes, of course.

I think that the best way to see things is not to consider that 
"sparse output offset in char*". As you have already seen, what
sparse produce after linearization is more low-level that LLVM's IR,
it's closer to what a CPU would see. So I think you should see
sparse's offset simply as an *address offset*, the values involved
being the values that would in the register of some CPU.

-- Luc 
