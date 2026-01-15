Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D06299AAB;
	Thu, 15 Jan 2026 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768518084; cv=none; b=DUrSl/vphuLYoRNu3XzwrsTntC+NJEsXuCQ6E3CifwT+PMf/STgUjTa7K+PSCLRrj9D7w+cDaHCk/ZnFL6LSsVi+O4Nt7ZjbrOMZOoGk0Pdm9xLpCjNuEqNGGz1jiw6m2VfR3FQ7REc0sXJ3i9jDaghBs9W8LWh/5ctCM6oEl24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768518084; c=relaxed/simple;
	bh=2Y4aFG4LAGkCN7lGD12I3005Rj2YsjfuDSzZWGB2q1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cyouHEIrca6+5ugVQ+FM/aGTLrE5tdH3/VbiE4l0bc8bt3D5FNTHh0CKdyb4oh5sFMzXhrniOjdAhP58KIQlwsq+0oGeERFDzzGxoaDL07MEiSQWMKtVHlec5XneN/k3Qpe8SHj42HgpM0LfeWVjSJxpxyzPncD+8phQrVuaKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnNE2bH6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnNE2bH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A782C116D0;
	Thu, 15 Jan 2026 23:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768518083;
	bh=2Y4aFG4LAGkCN7lGD12I3005Rj2YsjfuDSzZWGB2q1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qnNE2bH6fC9WSUZlfNEotz/D6aKTt85lQZtlhiM9dOqfwxDBpZRgc+0MUdCKW9oFi
	 cgZAL4ZdXPUeD1d6vMjmz9U69jCMtDZa5gYWlEY8wlNdYkTYnj7oi4jqR99oYi4e5W
	 oVqfaogzh7nLVGPr0CZ1H7OCFhzPYCpPZksSr8juE6Fig5lcU3Dc8d469OTPPF9AaC
	 Vn96TjlGppkD9A1qecxx6ersBDrdsFnLlGHe+E73xh2pq+iAPY+yQfyVB/RF0UvV/j
	 o/r0yuXENhS4lQYnxEkPWV97SLRt5oi062MAz+W8wVOtaGsPsIyqB9iSHaouKiigHM
	 fvTOucKMhaFog==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <lkp@intel.com>, Ian Rogers <irogers@google.com>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 x86@kernel.org, sparse@chrisli.org, linux-sparse@vger.kernel.org, Marco
 Elver <elver@google.com>
Subject: Re: [tip:timers/vdso 12/14] net/rds/ib_cm.c:96:35: sparse: sparse:
 incorrect type in argument 1 (different modifiers)
In-Reply-To: <20260115211120.GD831050@noisy.programming.kicks-ass.net>
References: <202601150001.sKSN644a-lkp@intel.com> <87v7h23cb0.ffs@tglx>
 <20260115211120.GD831050@noisy.programming.kicks-ass.net>
Date: Fri, 16 Jan 2026 00:01:19 +0100
Message-ID: <87ms2e32gw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 15 2026 at 22:11, Peter Zijlstra wrote:

> On Thu, Jan 15, 2026 at 08:28:51PM +0100, Thomas Gleixner wrote:
>> On Thu, Jan 15 2026 at 00:36, kernel test robot wrote:
>> 
>> Cc+ sparse folks.
>> 
>> > sparse warnings: (new ones prefixed by >>)
>> >>> net/rds/ib_cm.c:96:35: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
>> >    net/rds/ib_cm.c:96:35: sparse:     expected void *
>> >    net/rds/ib_cm.c:96:35: sparse:     got restricted __be64 const *
>> >    net/rds/ib_cm.c:103:27: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
>> >    net/rds/ib_cm.c:103:27: sparse:     expected void *
>> >    net/rds/ib_cm.c:103:27: sparse:     got restricted __be64 const *
>> 
>> After staring a while at it, it turns out that get_unaligned_t(), which
>> uses __unqual_scalar_typeof() to get an unqualified type makes sparse
>> unhappy when the data type is __be64 (or any other __beNN variant).
>> 
>> __beNN is annotated with __attribute__((bitwise)) when sparse is invoked
>> (#ifdef CHECKER). That allows sparse to detect incompatible math
>> operations with __beNN variables.
>> 
>
> Per:
>
>   https://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git/commit/?id=dc9efe442b8949234a6599fdc94dc7221dd040e1
>
> it seems Sparse now knows about __typeof_unqual__; and it looks like the
> implementation does what you want here (although I've not tested it).
>
> Something like so perhaps, which then mandates the very latest Sparse.

I tried that before and sparse is still upset:

  net/rds/ib_cm.c:96:35: warning: incorrect type in argument 1 (different modifiers)
  net/rds/ib_cm.c:96:35:    expected void *
  net/rds/ib_cm.c:96:35:    got restricted __be64 const *
  net/rds/ib_cm.c:103:27: warning: incorrect type in argument 1 (different modifiers)
  net/rds/ib_cm.c:103:27:    expected void *
  net/rds/ib_cm.c:103:27:    got restricted __be64 const *

This time I looked deeper and it seems that USE_TYPEOF_UNQUAL is not
set.

If I force it to be set and use a proper compiler and top of tree
sparse, everything seems to be happy.

Figuring that out is something for tomorrow...

Thanks,

        tglx

