From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2] add __builtin functions for isinf_sign, isfinite and
 isnan
Date: Thu, 16 Nov 2017 18:04:56 -0700
Message-ID: <f37fa631-edac-8de1-1cb4-4bd1edd807b2@deltatee.com>
References: <20171116230817.10011-1-logang@deltatee.com>
 <CANeU7Q=hr0OKtHk1gVsN2q1qzUxJ6URFsOY+YQtu_ThrB8UenA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:47554 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754235AbdKQBE6 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Nov 2017 20:04:58 -0500
In-Reply-To: <CANeU7Q=hr0OKtHk1gVsN2q1qzUxJ6URFsOY+YQtu_ThrB8UenA@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 11/16/2017 5:02 PM, Christopher Li wrote:
> In the history we are having header file issue with cygwin and other compile
> environment due to sparse don't understand other system macros. It is
> better to have sparse able to run the validations test without have to fix
> every single system macro define. It is kind of expect to be broken on new
> and untested platform. There for, best to have no system header in the
> validation test.

Fair enough,

Thanks.

Logan

