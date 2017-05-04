From: Lance Richardson <lrichard@redhat.com>
Subject: Re: [PATCH v4] sparse: add support for _Static_assert
Date: Thu, 4 May 2017 11:46:55 -0400 (EDT)
Message-ID: <99956653.4916117.1493912815498.JavaMail.zimbra@redhat.com>
References: <20170503165518.7625-1-lrichard@redhat.com> <20170503235403.6i5za2wa526fmp6w@desk.local> <CAMHZB6Gjf5gX92yiGshRgCpCLM=xuxBkXyDQ=RQA=gx6bG3PpQ@mail.gmail.com> <1089027793.4868687.1493906030607.JavaMail.zimbra@redhat.com> <20170504145834.mef3psritw2lxf35@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753864AbdEDPq4 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 11:46:56 -0400
In-Reply-To: <20170504145834.mef3psritw2lxf35@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

> From: "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>
> To: "Lance Richardson" <lrichard@redhat.com>
> Cc: "Linux-Sparse" <linux-sparse@vger.kernel.org>
> Sent: Thursday, 4 May, 2017 10:58:35 AM
> Subject: Re: [PATCH v4] sparse: add support for _Static_assert
> 
> On Thu, May 04, 2017 at 09:53:50AM -0400, Lance Richardson wrote:
> > Thanks for the quick feedback, will incorporate in v5.
> 
> I also saw a small issue, possibly related to the problem with
> the mixup between 'declaration-list' and 'struct-declarator-list'
> that you noticed. In the following code, the static assert is not
> recognized:
> 	void foo(void)
> 	{
> 		int i = 0;
> 		for (_Static_assert(1, "ok"); 1; )
> 			;
> 		for (_Static_assert(0, "ko"); 1; )
> 			;
> 	}
> 
> It should because (since C99) the first part of the for-statement
> is just a 'declaration', which include the static assert.
> Not that it's very important, though.
> 
> Probably, it's best to leave it as is for the moment and just
> add a new test case, annotated with 'check-known-to-fail'.
> 
> -- Luc
> 

Hi Luc,

I'm not sure it should be accepted; the standard doc says:

    "The declaration part of a for statement shall only declare
     identifiers for objects having storage class auto or register."
 
But _Static_assert() doesn't declare an identifier.

gcc accepts this syntax, although clang does not.  I did find this discussion:

    https://reviews.llvm.org/D9113

Which points to a working group discussion that made it sound as
though _Static_assert() should not be accepted in for-loop declarations:

    www.open-std.org/JTC1/SC22/WG14/13677

As you say, probably best to leave this for now.

   Lance
