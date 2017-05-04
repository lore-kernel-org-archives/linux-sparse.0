From: Lance Richardson <lrichard@redhat.com>
Subject: Re: [PATCH v4] sparse: add support for _Static_assert
Date: Thu, 4 May 2017 09:56:31 -0400 (EDT)
Message-ID: <1628848509.4869836.1493906191848.JavaMail.zimbra@redhat.com>
References: <20170503165518.7625-1-lrichard@redhat.com> <CANeU7Q=pC0Q2z3xtACq1AJ89Y3mr8aNEpo6GO42y6n0MuxV0ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755241AbdEDN4c (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 09:56:32 -0400
In-Reply-To: <CANeU7Q=pC0Q2z3xtACq1AJ89Y3mr8aNEpo6GO42y6n0MuxV0ug@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

> From: "Christopher Li" <sparse@chrisli.org>
> To: "Lance Richardson" <lrichard@redhat.com>
> Cc: "Linux-Sparse" <linux-sparse@vger.kernel.org>
> Sent: Wednesday, 3 May, 2017 11:03:22 PM
> Subject: Re: [PATCH v4] sparse: add support for _Static_assert
> 
> On Wed, May 3, 2017 at 12:55 PM, Lance Richardson <lrichard@redhat.com>
> wrote:
> > +               } else if (token_type(token) == TOKEN_IDENT &&
> > +                          (keyword = lookup_keyword(token->ident,
> > NS_KEYWORD)) &&
> > +                          keyword->op == &static_assert_op) {
> 
> I think you should add _Static_assert into header file "ident-list.h"
> then you can simplify this test as:
> 
> else if (token_type(token) == TOKEN_IDENT &&
>             token->ident == &_Static_assert_ident)
> 
> We don't need to go through a keyword look up then test
> the keyword->op == &static_assert_op.
> 
> Chris
> 

Makes sense, thanks for the suggestion. This should also address Luc's
comment about "extern int _Static_assert;" being accepted in the v4 version.

Will fold into v5.

Thanks,

   Lance
