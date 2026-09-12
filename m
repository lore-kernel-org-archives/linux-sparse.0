Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7C4BEE5F;
	Sat, 12 Sep 2026 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192672; cv=none; b=P0sR7VrzdGNb6LTZR+vyEZmf9C2WHY/2bENZAPscg9DMR3wj+c1uplglAV/oeMbtwE1Hszx0kCLjSSxMHIZEtyCuABFrAOMLpnfL+326EIDk38RUm6DL3aaJC7ruI39crWk66OB3ghy8flobWFg97+4vdbQ1woQwHvoq+DMzC/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192672; c=relaxed/simple;
	bh=Rcj9FY1u7DeFsZyQHQT3wFpcx6FB1JM6CIJykUWQ+LI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ShGlaNYJyNM0wcsHB1+hhZj1IUF+QNPFyBaYComuJjJ+DjR2I8ZkWNF9h/gE6BvnhrhSdbPCEMKFj2ry1gvN4beMpG0RJYhkZJ+9zyD5ENclcB+lGqF0p4uyDAodNakqk/YzUveFvzqK1u5YpPQjaJajerYEyP170euPceWHJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W9QWPMBr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W9QWPMBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBBD1F000FF;
	Sat, 12 Sep 2026 05:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789192670;
	bh=U0SBV4CnGKvvNIIMNW/AkFFYrokvu33qARejmqNfK7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W9QWPMBrCBYQPao72IDryRFjPwSSSzrFQQnrmLzru4nkSfY7n6kvfdGou8tEUsaBz
	 YXnJ7trlUURtUmQ5q92Z9tjACJ6M2DwkICOvZNuFJCGLzkDH1br2fjmd7x47mEvCDa
	 ftdLLENxCy+9QbpE3RoB2EsWDrkbkAkX7SPqo58c=
Date: Fri, 11 Sep 2026 22:57:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett"
 <liam@infradead.org>, Yury Norov <ynorov@nvidia.com>, Chris Li
 <sparse@chrisli.org>, Alice Ryhl <aliceryhl@google.com>, Andrew Ballance
 <andrewjballance@gmail.com>, linux-sparse@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/3] compiler.h: add ASSERT_STATIC_STORAGE()
Message-Id: <20260911225749.8727d23eb76b93141f08e574@linux-foundation.org>
In-Reply-To: <20260911221444.1523311-2-ynorov@nvidia.com>
References: <20260911221444.1523311-1-ynorov@nvidia.com>
	<20260911221444.1523311-2-ynorov@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 18:14:41 -0400 Yury Norov <yury.norov@gmail.com> wrote:

> Static lock initializers rely on a persistent object address when lockdep
> assigns a lock-class key. Using such an initializer for an automatic local
> object can compile successfully but disable lockdep on the first lock
> acquisition.
> 
> Add ASSERT_STATIC_STORAGE() for declaration macros that require
> static storage duration. It declares an unused static pointer initialized
> with the object's address. An automatic local object's address is not a
> valid static initializer, so the compiler rejects it.
> 
> Mirror the helper in tools/include/linux/compiler.h because the userspace
> radix-tree tests include the kernel IDA and Maple Tree headers with the
> tools compiler definitions.
> 
> For example:
> 
>   void example(void)
>   {
>           int object;
>           ASSERT_STATIC_STORAGE(object);
>   }
> 
> GCC reports:
> 
>   error: initializer element is not constant
>     name##_storage_check = &(name)
>                            ^
>   note: in expansion of macro 'ASSERT_STATIC_STORAGE'
>     ASSERT_STATIC_STORAGE(object);
> 
> File-scope objects and static local objects remain valid. The helper takes
> an object identifier and must be used as a declaration after that object
> has been declared.
> 

Thanks, I'll queue it.

Sashiko wants the same treatment for a few other macros:
	https://sashiko.dev/#/patchset/20260911221444.1523311-1-ynorov@nvidia.com
