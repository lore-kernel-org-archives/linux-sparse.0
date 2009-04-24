From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Add missing checks for Waddress-space
Date: Fri, 24 Apr 2009 15:53:58 -0700
Message-ID: <70318cbf0904241553h58e18921q35c6001ad51cc662@mail.gmail.com>
References: <20090423222519.48191d61@notas>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:14227 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbZDXWx6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 24 Apr 2009 18:53:58 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1179719rvb.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Apr 2009 15:53:58 -0700 (PDT)
In-Reply-To: <20090423222519.48191d61@notas>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Martin Nagy <nagy.martin@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Apr 23, 2009 at 1:25 PM, Martin Nagy <nagy.martin@gmail.com> wrote:
>
> Some of these are missing in evaluate.c. Maybe we should change the
> option to not consider address space at all, if unset. It would be much
> easier to make attribute_address_space() ignore it.

I think disable it at attribute_address_space() might be better.
Otherwise is_same_type() will still return false for address space difference.
There are too many places to track down the address space comparison.

Chris
