From: Lance Richardson <lrichard@redhat.com>
Subject: Re: [PATCH v3] sparse: add support for static assert
Date: Tue, 14 Jun 2016 10:49:12 -0400 (EDT)
Message-ID: <481469876.53571906.1465915752753.JavaMail.zimbra@redhat.com>
References: <1454989031-12240-1-git-send-email-lrichard@redhat.com> <20160315225203.GC2679@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:46423 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbcFNOtO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 14 Jun 2016 10:49:14 -0400
In-Reply-To: <20160315225203.GC2679@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

----- Original Message -----
> From: "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>
> To: "Lance Richardson" <lrichard@redhat.com>
> Cc: linux-sparse@vger.kernel.org
> Sent: Tuesday, March 15, 2016 6:52:03 PM
> Subject: Re: [PATCH v3] sparse: add support for static assert
> 
> On Mon, Feb 08, 2016 at 10:37:10PM -0500, Lance Richardson wrote:
> > This patch introduces support for _Static_assert() in global,
> > function, and struct/union declaration contexts (as currently supported
> > by gcc).
> > 
> > Tested via:
> >    - kernel build with C=1 CF=-D__CHECK_ENDIAN__
> >    - build/check large code base making heavy use of _Static_assert()
> >    - "make check" with added test cases for static assert support
> > 
> > Signed-off-by: Lance Richardson <lrichard@redhat.com>
> 
> 
> Fine for me.
> 
> Feel free to add
>   Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> 
> Chris, I have already reviwed this in January and Richard have taken
> my remarks in account.
> Do you think you you will have some time soon to look at it?
> 
> 
> Regards,
> Luc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Dusting this one off... "ping"?

Thanks and Regards,

   Lance
