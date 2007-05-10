From: Tommy Thorn <tommy@numba-tu.com>
Subject: A Sparse C Interpreter [was: looking for any examples of using sparse]
Date: Thu, 10 May 2007 10:46:20 -0700
Message-ID: <46435A6C.8070203@numba-tu.com>
References: <bb2368c50705090732w4948fcc0ka3aea74ba22945b5@mail.gmail.com> <c38fc0de0705092334u6c3635e6i5fc1dec91a00f319@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 208.65.183.75.static.etheric.net ([208.65.183.75]:4370 "EHLO
	numba-tu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbXEJSBd (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 May 2007 14:01:33 -0400
Received: from [192.168.1.6] (babo [192.168.1.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by numba-tu.com (Postfix) with ESMTP id 18BAA82D1
	for <linux-sparse@vger.kernel.org>; Thu, 10 May 2007 10:43:24 -0700 (PDT)
In-Reply-To: <c38fc0de0705092334u6c3635e6i5fc1dec91a00f319@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Mike Goodwin wrote:
> I hear you, being in a similar situation myself. I believe I roughly
> understand what is going on (though mostly I only care about up until
> the parsing stage), but not well enough to explain.
....

One thing I think might be useful, and likely fun to create, is a C interpreter 
on top of Sparse. As far as possible, it should use the Sparse data structures 
directly (speed is of tertiary concern).

I believe having this would make it easier to understand some of the data 
structures in Sparse.

Cheers,
Tommy
