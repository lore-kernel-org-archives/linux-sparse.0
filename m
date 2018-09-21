From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v8 16/20] kasan: add hooks implementation for tag-based mode
Date: Fri, 21 Sep 2018 16:28:27 +0200
Message-ID: <CAAeHK+wBcmoikVedBZFSGC4UGsF578AKCzFhNFNgMuJe6oWvZA@mail.gmail.com>
References: <cover.1537383101.git.andreyknvl@google.com> <d3f5102da9792370158ed02203d8066dd5e07ff7.1537383101.git.andreyknvl@google.com>
 <CACT4Y+aD=ghemsrBaw2N_FJWtrWNf3r=BWxjWLkKBjNB-s=4Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+aD=ghemsrBaw2N_FJWtrWNf3r=BWxjWLkKBjNB-s=4Vg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kst>
List-Id: linux-sparse@vger.kernel.org

On Fri, Sep 21, 2018 at 1:37 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Sep 19, 2018 at 8:54 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>> +       /*
>> +        * Since it's desirable to only call object contructors ones during
>
> s/ones/once/

Will fix.

>
>> +        * slab allocation, we preassign tags to all such objects.
>
> While we are here, it can make sense to mention that we can't repaint
> objects with ctors after reallocation (even for
> non-SLAB_TYPESAFE_BY_RCU) because the ctor code can memorize pointer
> to the object somewhere (e.g. in the object itself). Then if we
> repaint it, the old memorized pointer will become invalid.

Will mention.

>> -       kasan_unpoison_shadow(object, size);
>> +       /* See the comment in kasan_init_slab_obj regarding preassigned tags */
>> +       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) &&
>> +                       (cache->ctor || cache->flags & SLAB_TYPESAFE_BY_RCU)) {
>> +#ifdef CONFIG_SLAB
>> +               struct page *page = virt_to_page(object);
>> +
>> +               tag = (u8)obj_to_index(cache, page, (void *)object);
>> +#else
>> +               tag = get_tag(object);
>> +#endif
>
> This kinda _almost_ matches the chunk of code in kasan_init_slab_obj,
> but not exactly. Wonder if there is some nice way to unify this code?
>
> Maybe something like:
>
> static u8 tag_for_object(struct kmem_cache *cache, const void *object, new bool)
> {
>     if (!IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
>         !cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
>         return random_tag();
> #ifdef CONFIG_SLAB
>     struct page *page = virt_to_page(object);
>     return (u8)obj_to_index(cache, page, (void *)object);
> #else
>     return new ? random_tag() : get_tag(object);
> #endif
> }
>
> Then we can call this in both places.

Will do, however I think it's better to do the CONFIG_KASAN_SW_TAGS
check outside this helper function.

> As a side effect this will assign tags to pointers during slab
> initialization even if we don't have ctors, but it should be fine (?).

We don't have to assign tag in this case, can just leave 0xff.
