Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD054705F;
	Wed, 30 Sep 2026 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798357; cv=none; b=m1spJKc6eNKQ8iydnSyUdm9403RETMmR7kIUUlT0i5K6T8wF1+dpaOfpYlH94lai/iXB5OdjCAl5J3cmxSWjNhDSz9yHT2TuEr/H+lJXX1x8FKCUahf5QxcKEBHOqjhUEZjXXBQBwx8K4FBcnFVwdtiPcZT3vXGg+c0MFVfYs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798357; c=relaxed/simple;
	bh=JCzuZUM76r47/VUOZi0wd5OB3cm0cpp7HAOzj6q0k3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6kyUN0Zq6wwPwiXFJzKtc1mibBxMIhuFesrjr8Ny1lJ5L5TUlgvkO+EgVAGEaU3Vcl78RNbOQwgzhjWeYHN2yJoHgMjyJkiOPNRdi4JhYZxZ0LWQKVEamtFXRscpJZkIcoJLmQJjjDHwOHv4gmCU0A3ljJ5YftuxANxAPIdUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=IYqZa4V4; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="IYqZa4V4"
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id CD79C401EA;
	Wed, 30 Sep 2026 19:59:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 13F0620028;
	Wed, 30 Sep 2026 19:59:04 +0000 (UTC)
Date: Wed, 30 Sep 2026 15:59:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: nanshuaibo <nanshuaibo811@163.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Chris Li <sparse@chrisli.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sparse@vger.kernel.org
Subject: Re: [PATCH] tracing: Make branch profiler counters atomic
Message-ID: <20260930155901.6cb8f18f@fedora>
In-Reply-To: <20260930030728.1144418-1-nanshuaibo811@163.com>
References: <20260930030728.1144418-1-nanshuaibo811@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 13F0620028
X-Stat-Signature: 6u691wjcud81zra5kckdat1cnsicpqpf
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+PYHKQr4C+fg7B35RPDkqsrXD1gS8CcbY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=jqwjuI2ZMTqfAUuoUNReCHhPu1OCmfrg2qPHGa/vWpQ=; b=IYqZa4V4tRqmsBgz6jHlnGznzdqOFVzH7/miekD0DvFjdvTjh51UKPbu6F9Q4q5bY2TrQR9BggMqBiz4mo58jVqdFe/QyNWYYTML/z+DnArV8btjLfgGrncZPh2VJDbo8AuqHa28AdDedZS5+wvQ0RCMNXRVZH4VpPSlc2Ch/wU=
X-HE-Tag: 1790798344-34956
X-HE-Meta: U2FsdGVkX1+YBuFE00jxhYGVkXo4Qp3flpjllPDDR6oJiC50gjg9S8JvRbPGrnqGFoxC7vXkorQ5XSauaS0/FiVuwjyL+i1rnhAH6fRJ9PqFQCjwAOiyG+agsnCdGeC/GvSP91O+ENKhm9irKVOL0SdQ8fnAg+AAuO/B9d6a9d+6381uKv2lXa463W23CYtrWZxNx7obGGdggoRUbHch0gzcZ2nV7NSPEheVWk1f/9iTRoGSe06epmAQFT6yhpwQ+OCfV8VJQhxnQ3q1pzlNwxqjZOye1skzoZ8LP9DH6BxUHf5XwLJOnE65oSBm2UbkLvG8lX4cXRt7AiXQ5X7WI/vH2HoSyJ3A

On Wed, 30 Sep 2026 11:07:28 +0800
nanshuaibo <nanshuaibo811@163.com> wrote:

> The branch profiler updates its static counters from arbitrary contexts. Concurrent updates can race and lose counts. KCSAN reports a data race between ftrace_likely_update() invocations.
> 
> Use relaxed compiler atomic operations for the counters. The profiler metadata is defined in compiler_types.h, before the kernel atomic API is available. The counters do not order accesses to other data.
> 
> Also use atomic loads when reading the counters for tracefs output and sorting, so readers do not race with atomic writers.
> 
> Tested on x86_64 QEMU/KVM with KCSAN and CONFIG_PROFILE_ANNOTATED_BRANCHES=y. The baseline reports the race in ftrace_likely_update(); it is not reported after this change.

FYI, Change log lines should be capped at 76 characters except for cut
and pasted output.

That said, NAK to the patch. The branch profile is a best effort and
known to be racy. It's to find where branches are most traveled, Their
exact numbers are not meaningful. No need for atomic operations.

-- Steve
