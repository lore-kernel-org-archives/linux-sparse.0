From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2] add __builtin functions for isinf_sign, isfinite and
 isnan
Date: Fri, 17 Nov 2017 16:39:37 -0700
Message-ID: <b16d895e-d4fa-3590-4f0d-b9c0e8a754d3@deltatee.com>
References: <20171116230817.10011-1-logang@deltatee.com>
 <20171117081348.5cdzuctwi6i3ltu6@ltop.local>
 <CAExDi1QA-NV0JYKnOzxxnkLfimzr9Bw6Q0irKxmmnByfP5XeWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:53666 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966214AbdKQXjj (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Nov 2017 18:39:39 -0500
In-Reply-To: <CAExDi1QA-NV0JYKnOzxxnkLfimzr9Bw6Q0irKxmmnByfP5XeWA@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>



On 17/11/17 04:28 PM, Luc Van Oostenryck wrote:
> Hmmm, looking at this closer, I only notice now that those builtins
> are of the type-generic kind. Declaring them with a prototype as if
> taking a float won't play nicely once you use them with a double or
> a long double. Alas, there is not yet real support for type-generic
> builtins. One solution would be:
>          extern int __builtin_isfinite(long double);
> Another one would be to use:
>          extern int __builtin_isfinite(...);
> but that is not C99 compliant (not sure if sparse complain).

This is true, but when I test with the validation suite sparse does not 
seem to complain if it's a long double, double or float. So I don't 
really see an actual issue.

> Note, that there is also a few more builtins of the same family.

Yes, though GCC's documentation is less than clear on all that are 
available... I only added ones I knew to exist based on the code I'm 
working on and examining the system headers.

Logan
