<?php

declare(strict_types=1);

/*
 * This file is part of the Sigwin Yassg project.
 *
 * (c) sigwin.hr
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

namespace Sigwin\YASSG;

/**
 * @template TKey of string
 * @template TValue of object
 *
 * @template-extends \ArrayAccess<TKey, TValue>
 * @template-extends \IteratorAggregate<TKey, TValue>
 */
interface Collection extends \ArrayAccess, \Countable, \IteratorAggregate
{
    public function column(string $name): array;

    public function total(): int;
}
