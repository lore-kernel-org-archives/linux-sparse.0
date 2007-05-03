From: "Chris Li" <christ.li@gmail.com>
Subject: Re: Listing special marked symbols - attribute section
Date: Thu, 3 May 2007 15:37:17 -0700
Message-ID: <70318cbf0705031537o4afd1bf8v39635e38c32548c8@mail.gmail.com>
References: <OFD5E73F1F.17F8F44A-ONC12572CF.003EC61A-C12572D0.00319C0B@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:23742 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767457AbXECWhS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 May 2007 18:37:18 -0400
Received: by nz-out-0506.google.com with SMTP id o1so685239nzf
        for <linux-sparse@vger.kernel.org>; Thu, 03 May 2007 15:37:18 -0700 (PDT)
In-Reply-To: <OFD5E73F1F.17F8F44A-ONC12572CF.003EC61A-C12572D0.00319C0B@br-automation.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: linux-sparse@vger.kernel.org

On 5/3/07, Thomas Schmid <Thomas.Schmid@br-automation.com> wrote:
> In 0.3 are several extensions to parse attributes, but it seems that
> <sectionname> isn't stored anywhere.
> Is it possible to get <sectionname>?
>
> If there is no way to get <sectionname> in the actual implementation, i
> think of an extension in struct ctype.
> Any comments?
> Would this be useful for someone else?

Yes, it would be useful. The easiest way is just increase the ctype to include
a pointer to section name. The biggest objection is from the fact that
symbol/ctype
is the most common data structure in the sparse. If we increase the size
of ctype, there is a huge impact of the sparse memory usage.

I did try to use some kind of extend the attributes. The idea is have
the most common
attribute embed in ctype. The not common ones will store in a extend
attribute structure.
The extend attribute structure itself is flat. The initial
implementation will only contain
address space and context. I found myself keep breaking the existing
address space
attributes.

The attribute propagation not very clear in sparse. Some times we use assignment
and some times the attribute is inherited from implicit memcpy and
some time we strip
the attribute out. I wish to have a more unify way to define how
attribute are created
and propagate through the ctype, maybe a table or some thing.

Chris
