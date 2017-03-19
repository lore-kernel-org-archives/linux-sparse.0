From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm failure when comparing pointers
Date: Sun, 19 Mar 2017 16:33:24 +0100
Message-ID: <20170319153323.drqt23dridw65544@macpro.local>
References: <CACXZuxc=TMZyi9LPJ6KGfDeNZYBrkZ4gp2p8Z75tbPhKfCnmuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34104 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbdCSPd2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:33:28 -0400
Received: by mail-wm0-f42.google.com with SMTP id 196so14868150wmm.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:33:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxc=TMZyi9LPJ6KGfDeNZYBrkZ4gp2p8Z75tbPhKfCnmuw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Mar 13, 2017 at 11:47:04PM +0000, Dibyendu Majumdar wrote:
> Pointer comparions are failing LLVM validation if they are not the
> same type. One way to resolve this is to cast the pointer to integer
> before comparing. I am trying out following approach. In
> output_op_compare(), I separated out the pointer case as follows:

This is fixed in the llvm-fixes-v3 serie I submitted yesterday.
 
-- Luc
