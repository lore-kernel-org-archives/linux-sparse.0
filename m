From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3] sparse: add support for static assert
Date: Tue, 15 Mar 2016 23:52:03 +0100
Message-ID: <20160315225203.GC2679@macpro.local>
References: <1454989031-12240-1-git-send-email-lrichard@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33760 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbcCOWwI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 18:52:08 -0400
Received: by mail-wm0-f44.google.com with SMTP id l68so165686237wml.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 15:52:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1454989031-12240-1-git-send-email-lrichard@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Feb 08, 2016 at 10:37:10PM -0500, Lance Richardson wrote:
> This patch introduces support for _Static_assert() in global,
> function, and struct/union declaration contexts (as currently supported
> by gcc).
> 
> Tested via:
>    - kernel build with C=1 CF=-D__CHECK_ENDIAN__
>    - build/check large code base making heavy use of _Static_assert()
>    - "make check" with added test cases for static assert support
> 
> Signed-off-by: Lance Richardson <lrichard@redhat.com>


Fine for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


Chris, I have already reviwed this in January and Richard have taken
my remarks in account.
Do you think you you will have some time soon to look at it?


Regards,
Luc
