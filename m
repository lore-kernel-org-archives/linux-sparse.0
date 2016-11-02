From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] ptrlist: use after free in last_ptr_list()
Date: Wed, 2 Nov 2016 13:48:45 +0100
Message-ID: <20161102124844.GA12544@macbook.home>
References: <20160613094517.GA25301@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33915 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754807AbcKBMst (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 08:48:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id p190so2922379wmp.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 05:48:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160613094517.GA25301@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Jun 13, 2016 at 12:45:17PM +0300, Dan Carpenter wrote:
> This change is similar to 2e7dd34d11cb ('ptrlist: reading deleted items
> in NEXT_PTR_LIST()').  If we use DELETE_CURRENT_PTR() then we can end up
> with a list->nr that is zero meaning that we have to go back another
> list->prev to find what we want.  Otherwise we dereference 0xf0f0f0f0
> and crash.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  ptrlist.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/ptrlist.h b/ptrlist.h
> index 61e159f..6f90c8f 100644
> --- a/ptrlist.h
> +++ b/ptrlist.h
> @@ -78,6 +78,8 @@ static inline void *last_ptr_list(struct ptr_list *list)
>  	if (!list)
>  		return NULL;
>  	list = list->prev;
> +	while (list->nr == 0)
> +		list = list->prev;
>  	return PTR_ENTRY(list, list->nr-1);
>  }
>  
> -- 


Hi,

while trying to find a test case for this one, I noticed that something
as simple as:
	void rem_rev(struct vpl *list)
	{
		void *last;
		void *ptr;
	
		FOR_EACH_PTR_REVERSE(list, ptr) {
			DELETE_CURRENT_PTR(ptr);
			last = last_ptr_list((struct ptr_list *)list);
		} END_FOR_EACH_PTR_REVERSE(ptr);
	}

loops forever on a list with 1 element with your patch.
Without your patch, last_ptr_list() return an invalid pointer instead of NULL.

So, I don't think your patch is the right solution but, yes somethings
should be done about this.


Cheers,
Luc Van Oostenryck
