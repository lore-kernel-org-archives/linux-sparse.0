From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v6 08/18] khwasan: preassign tags to objects with ctors or SLAB_TYPESAFE_BY_RCU
Date: Wed, 12 Sep 2018 18:36:08 +0200
Message-ID: <CACT4Y+awX48sFAYFCgx1Q-nJ=QrBhr08psMmHr+hDeCsQc0NRw@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <95b5beb7ec13b7e998efe84c9a7a5c1fa49a9fe3.1535462971.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <95b5beb7ec13b7e998efe84c9a7a5c1fa49a9fe3.1535462971.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kst>
List-Id: linux-sparse@vger.kernel.org

On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> An object constructor can initialize pointers within this objects based on
> the address of the object. Since the object address might be tagged, we
> need to assign a tag before calling constructor.
>
> The implemented approach is to assign tags to objects with constructors
> when a slab is allocated and call constructors once as usual. The
> downside is that such object would always have the same tag when it is
> reallocated, so we won't catch use-after-frees on it.
>
> Also pressign tags for objects from SLAB_TYPESAFE_BY_RCU caches, since
> they can be validy accessed after having been freed.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/slab.c | 6 +++++-
>  mm/slub.c | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index 6fdca9ec2ea4..3b4227059f2e 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -403,7 +403,11 @@ static inline struct kmem_cache *virt_to_cache(const void *obj)
>  static inline void *index_to_obj(struct kmem_cache *cache, struct page *page,
>                                  unsigned int idx)
>  {
> -       return page->s_mem + cache->size * idx;
> +       void *obj;
> +
> +       obj = page->s_mem + cache->size * idx;
> +       obj = khwasan_preset_slab_tag(cache, idx, obj);
> +       return obj;
>  }
>
>  /*
> diff --git a/mm/slub.c b/mm/slub.c
> index 4206e1b616e7..086d6558a6b6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1531,12 +1531,14 @@ static bool shuffle_freelist(struct kmem_cache *s, struct page *page)
>         /* First entry is used as the base of the freelist */
>         cur = next_freelist_entry(s, page, &pos, start, page_limit,
>                                 freelist_count);
> +       cur = khwasan_preset_slub_tag(s, cur);
>         page->freelist = cur;
>
>         for (idx = 1; idx < page->objects; idx++) {
>                 setup_object(s, page, cur);
>                 next = next_freelist_entry(s, page, &pos, start, page_limit,
>                         freelist_count);
> +               next = khwasan_preset_slub_tag(s, next);
>                 set_freepointer(s, cur, next);
>                 cur = next;
>         }
> @@ -1613,8 +1615,10 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>         shuffle = shuffle_freelist(s, page);
>
>         if (!shuffle) {
> +               start = khwasan_preset_slub_tag(s, start);
>                 for_each_object_idx(p, idx, s, start, page->objects) {
>                         setup_object(s, page, p);
> +                       p = khwasan_preset_slub_tag(s, p);


As I commented in the previous patch, can't we do this in
kasan_init_slab_obj(), which should be called in all the right places
already?


>                         if (likely(idx < page->objects))
>                                 set_freepointer(s, p, p + s->size);
>                         else
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>
