From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
Date: Fri, 7 Feb 2020 11:39:24 -0800
Message-ID: <CAHk-=wjbhawNieeiEig4LnPVRTRPgY8xag7NuAKuM9NKXCTLeQ@mail.gmail.com>
References: <20200207081810.3918919-1-kafai@fb.com> <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Martin KaFai Lau <kafai@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, David Miller <davem@davemloft.net>, kernel-team@fb.com, Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Netdev <netdev@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Feb 7, 2020 at 10:07 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do think this is a good test-case for sparse. Luc, have you looked
> at what it is that then makes sparse use *so* much memory for this one
> line?

Looking at the profile, it's doing a lot of "copy_expression()".

Which comes from inlining.

I think the problem may be that with that macro expansion from hell we
end up with 28968 copies of cpumask_weight(), and sparse will inline
every one of them into the parse tree - even though basically none of
them are _used_.

In fact, it's worse than that: we end up having a few rounds of
inlining thanks to

static inline unsigned int cpumask_weight(const struct cpumask *srcp)
{
        return bitmap_weight(cpumask_bits(srcp), nr_cpumask_bits);
}

static __always_inline int bitmap_weight(const unsigned long *src,
unsigned int nbits)
{
        if (small_const_nbits(nbits))
                return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
        return __bitmap_weight(src, nbits);
}

static __always_inline unsigned long hweight_long(unsigned long w)
{
        return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
}

where those hweight*() things aren't simple either, they end up doing

  #define hweight32(w) (__builtin_constant_p(w) ? __const_hweight32(w)
: __arch_hweight32(w))
  #define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w)
: __arch_hweight64(w))

where the __const_hweight*() in turn are more expansions of a macro
with several levels in order to turn it all into a constant value.

So we may have "only" 28968 calls to cpumask_weight(), but it results
in millions of expressions being expanded.

If we did some basic simplification of constant ops before inlining,
that would likely help a lot.

But currently sparse does inline function expansion at type evaluation
time - so long before it does any simplification of the tree at all.

So that explains why sparse happens to react _so_ badly to this thing.
A real compiler would do inlining much later.

Inlining that early is partly because originally one of the design
ideas in sparse was to make inline functions act basically as
templates, so they'd react to the types of the context. But it really
bites us in the ass here.

Luc, any ideas? Yes, this is solvable in the kernel, but it does show
that sparse simply does a _lot_ of unnecessary work.

               Linus
