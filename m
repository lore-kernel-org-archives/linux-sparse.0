From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v4 12/13] fair.c: Use generic rbtree impl in fair
 scheduler
Date: Tue, 26 Jun 2012 14:15:49 +0200
Message-ID: <1340712949.21991.57.camel@twins>
References: <1340424048-7759-1-git-send-email-daniel.santos@pobox.com>
	 <1340424048-7759-13-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1340424048-7759-13-git-send-email-daniel.santos@pobox.com>
Sender: linux-doc-owner@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Turner <pjt@google.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Richard Weinberger <richard@nod.at>, Rob Landley <rob@landley.net>, Steven Rostedt <rostedt@goodmis.org>, Suresh Siddha <suresh.b.siddha@intel.com>
List-Id: linux-sparse@vger.kernel.org

On Fri, 2012-06-22 at 23:00 -0500, Daniel Santos wrote:
> +static inline long compare_vruntime(u64 *a, u64 *b)
> +{
> +#if __BITS_PER_LONG >= 64
> +       return (long)((s64)*a - (s64)*b);
> +#else
> +/* This is hacky, but is done to reduce instructions -- we wont use this for
> + * rbtree lookups, only inserts, and since our relationship is defined as
> + * non-unique, we only need to return positive if a > b and any other value
> + * means less than.
> + */
> +       return (long)(*a > *b);
> +#endif
> +} 

That's wrong.. suppose: a = 10, b = ULLONG_MAX - 10

In that case (s64)(a - b) = 20, however a > b is false.

And yes, vruntime wrap does happen.
