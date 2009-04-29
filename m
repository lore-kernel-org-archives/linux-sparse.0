From: Jeff Garzik <jeff@garzik.org>
Subject: Re: `char * s = "abc";' causes compile to crash with a segfault
Date: Wed, 29 Apr 2009 17:08:59 -0400
Message-ID: <49F8C1EB.5010909@garzik.org>
References: <op.us51m0w9ucb9g9@home-5db3af48a>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57207 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbZD2VJD (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Apr 2009 17:09:03 -0400
In-Reply-To: <op.us51m0w9ucb9g9@home-5db3af48a>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexander Sorockin <sorockin@yandex.ru>
Cc: linux-sparse@vger.kernel.org

Alexander Sorockin wrote:
> I realize that compile is only an example and you are probably familiar 
> with the problem, but just in case... I was playing around with compile 
> and here's what got.

Yes, that is expected behavior for the program merged as "silly sparse 
x86 backend" :)  There are many, many, many code generator shortcomings.


> Just out of curiosity, is sparse stable enough in general to be used as 
> a full-fledged front-end for a C compiler?

As long as you don't do super-weird, non-standard C:  sure.

	Jeff


