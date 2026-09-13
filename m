Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E712F1FED;
	Sun, 13 Sep 2026 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341207; cv=none; b=LhuKIU00hApPPlKiP8lnTo5RiuXK/2z6YbyRsy4BTqdCJVXuET2q7btNs554U+zkozcNGVHfS29pDvXaqR1GluB33i44zROQ+SouCdfOrmeQCts4Np668eXY4KdlBW0Blf8tITctPxDmytwVQXypiIDXPGfcuPU/2TF2BzVY20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341207; c=relaxed/simple;
	bh=/yFTq2TRqG0tvgEsqGrbjioo41O5Hwn6wAtodQ6dBbk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sDSLapMwcDx/+FcC/23HE/8G5iHngP/IaZY2II2WFbAm7ax0y+MMoIsqM3b01W1cJTFBsOx0SBMBpl3CyHM7QEip6dOcxd2Rxn7a4ABQPnGSNKBncCaG5dMng0Oq8uzrJpRbEsOO8IW8fMV1Q1eFN6tXRZLpc0tgQV+SpcWSbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zYcVK2v9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zYcVK2v9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7137E1F000FF;
	Sun, 13 Sep 2026 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789341205;
	bh=ATWZYkl6gXglOV8R8lb8BXtXhjp6jIzf5yrr28mOYNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=zYcVK2v9RI+Wmrk1Pu/ODVTZVKmwrwtmA10ni+A8Df4mUkVqiqiHgZ17gT8F0Yk/e
	 8KrNTD5UxXB/Eu3m3D9iDZNRpciGWIfhP25vAmNkLOIjZjL+U5jw/9/Hgo/5iu0TPx
	 7VNRpXIZ9/204VZVozy6ul97EjIYHuLym7P8C5mA=
Date: Sun, 13 Sep 2026 16:13:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 "Liam R. Howlett" <liam@infradead.org>, Chris Li <sparse@chrisli.org>,
 Alice Ryhl <aliceryhl@google.com>, Andrew Ballance
 <andrewjballance@gmail.com>, linux-sparse@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/3] compiler.h: add ASSERT_STATIC_STORAGE()
Message-Id: <20260913161324.8879b42314924d8264447f45@linux-foundation.org>
In-Reply-To: <aqXSkthkUVJNu2FD@yury>
References: <20260911221444.1523311-1-ynorov@nvidia.com>
	<20260911221444.1523311-2-ynorov@nvidia.com>
	<20260911225749.8727d23eb76b93141f08e574@linux-foundation.org>
	<aqXSkthkUVJNu2FD@yury>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 18:31:03 -0400 Yury Norov <ynorov@nvidia.com> wrote:

> > 
> > Thanks, I'll queue it.
> > 
> > Sashiko wants the same treatment for a few other macros:
> > 	https://sashiko.dev/#/patchset/20260911221444.1523311-1-ynorov@nvidia.com
> 
> Below is the list of candidates that my AI finds relevant:
> 
> [long list]
> 
> I planned to submit this hardening for them per the relevant subsystems
> after at least landing the ASSERT_STATIC_STORAGE() in -next.
> 
> If you're OK to move that material through your tree all in one,
> I can prepare it as a single series.

People often do this by sending patches into various maintainers.  It
can be pretty exhausting and unreliable - maintainer attentiveness
levels vary a lot.


Such a series is applying one concept in many places.  It's justifiable
to do this in a single series.


It gets me shouted at, but my preferred approach is to take all of it
into mm.git while ensuring that maintainers are cc'ed.  Results are
among:

i)   maintainer says ack.  Great, I keep the patch and upstream it

ii)  maintainer merges it.  Great, I drop the mm.git copy when the
     conflict is reported in linux-next.

iii) maintainer says nothing.  Oh well, I upstream it and hope for the
     best.

     iiiA): maintainer later shouts at me.  Oh well, I did
            my best, read your darn email.

So yes, send everything to everyone and I'll do this.
