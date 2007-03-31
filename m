From: "Suhabe Bugrara" <suhabe@stanford.edu>
Subject: Re: [PATCH 7] Adding the interrupt checker
Date: Fri, 30 Mar 2007 17:26:55 -0700
Message-ID: <5166c2f30703301726q2a3cfb91p7fdb5f7ae146d22d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:20359 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933133AbXCaA04 (ORCPT
	<rfc822;linux-sparse@VGER.KERNEL.ORG>);
	Fri, 30 Mar 2007 20:26:56 -0400
Received: by an-out-0708.google.com with SMTP id b33so659079ana
        for <linux-sparse@VGER.KERNEL.ORG>; Fri, 30 Mar 2007 17:26:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@VGER.KERNEL.ORG

On Thu, 2007-03-01 at 6:07:06, Pavel Roskin wrote:
> Moreover, I think that incorrect use of locking is a remaining major
> issue not covered by sparse.

Hello,

What particular locking usage rules would Sparse ideally check? I
guess this would include finding double locking/unlocking errors. Are
there other more important locking usage rules? Could locking errors
in the kernel be potentially more serious than dereferencing an
unchecked user pointer for example?

Suhabe
