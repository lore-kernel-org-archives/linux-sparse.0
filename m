From: Tommy Thorn <tommy@thorn.ws>
Subject: Re: Fwd: [PATCH 0/10] Sparse linker
Date: Wed, 03 Sep 2008 18:54:38 -0700
Message-ID: <48BF3FDE.10300@thorn.ws>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>	 <70318cbf0809031808u8610f3h4b3d53a7b76a7799@mail.gmail.com> <70318cbf0809031816m69565c5aj9417d9a2e136770d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from server204.webhostingpad.com ([69.65.0.218]:42315 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756613AbYIDI2q (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Sep 2008 04:28:46 -0400
In-Reply-To: <70318cbf0809031816m69565c5aj9417d9a2e136770d@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>, alexey.zaytsev@gmail.com

Christopher Li wrote:
> I would rather not have that 4 byte prepended to every
> structure. Serialize is just one short stage of the life cycle
> of those c structures. Having the permanent extra space
> for just that is unnecessary. That 4 bytes meta data also
> limits what C structure you can work on. All you need
> is being able to map a point into some serialize object
> to keep track which object is tracked and which one is not.
>
> After you serialized the data. The meta data can be drop
> completely. So the price to pay is for every unknown object
> pointer, you need to do a dictionary look up. Only during
> the dumping stage. But that price is actually very small,
> when you dumping objects. You are mostly limit by the disk
> any way. The plus side is: you can work with any objects.
> You don't need to waste extra memory for serialization
> when you are not doing serialization. You can leave the
> object allocation code unchanged.
>   

I concur and just wanted to point out that this technique has been used 
in the garbage collector for functional languages for the same reason: 
the type information is very small and almost completely static; no need 
to replicate it all over the data. It does make marshaling (this is the 
common terminology for what Alex calls "serialization") slightly more 
complicated.

Tommy



