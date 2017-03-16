From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential linearizer over simplication
Date: Thu, 16 Mar 2017 18:30:23 +0100
Message-ID: <20170316173022.ahagyzlzfi6cpigm@macbook.local>
References: <CACXZuxcf6TX8=9Cn=oa7-i_ok3KSeDUeyGg3ssdswjUFK=ADbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36822 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbdCPRb0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 13:31:26 -0400
Received: by mail-wm0-f43.google.com with SMTP id n11so117909443wma.1
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 10:30:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcf6TX8=9Cn=oa7-i_ok3KSeDUeyGg3ssdswjUFK=ADbg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 15, 2017 at 12:00:52AM +0000, Dibyendu Majumdar wrote:
> 
> The assignment of 1.0 to ut.t has been skipped. Does this look
> correct? Is there a way to switch off optimisation / simplification?

No, it's not correct.
Sparse do memops simplification wrongly, ignoring or at least
incorrectly taking aliasing in account.

-- Luc
